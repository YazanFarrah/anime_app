import 'dart:convert';

import 'package:anime_app/features/auth/screens/other%20users/users_profile_screen.dart';
import 'package:anime_app/features/pages/comments.dart';
import 'package:anime_app/models/current_user.dart';
import 'package:anime_app/network/remote/api_services.dart';
import 'package:anime_app/theme/theme.dart';
import 'package:anime_app/widgets/buttons/interact_button.dart';
import 'package:anime_app/widgets/dialogs/focused_menu.dart';
import 'package:anime_app/widgets/profile_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../models/post.dart';
import 'package:get/get.dart';

class PostContainer extends StatefulWidget {
  final Post post;
  PostContainer({
    super.key,
    required this.post,
  });

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,

      // to add padding to the entire post including the images
      //add wrap the container with padding instead of the column

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 10),
            child: Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PostHeader(post: widget.post),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        widget.post.text,
                      ),
                    ),
                    widget.post.images!.isNotEmpty
                        ? const SizedBox.shrink()
                        : const SizedBox(
                            height: 6.0,
                          ),
                  ]),
            ),
          ),
          // post.author.id == CurrentUser.userId
          // ?
          widget.post.images!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CarouselSlider(
                    carouselController: controller,
                    items: widget.post.images!.map(
                      (url) {
                        return Builder(
                          builder: (BuildContext context) => CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            // fit: BoxFit.contain,
                            // height: double.infinity,
                          ),
                        );
                      },
                    ).toList(),
                    options: CarouselOptions(
                      onPageChanged: (index, _) {
                        setState(() {
                          controller.jumpToPage(index);
                        });
                      },
                      // aspectRatio: 16 / 9,

                      // reverse: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      // height: 200,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          // : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _PostStats(post: widget.post),
          )
        ],
      ),
    );
  }
}

class PostHeader extends StatefulWidget {
  final Post post;
  const PostHeader({
    super.key,
    required this.post,
  });

  @override
  State<PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<PostHeader> {
  TextEditingController _editPostController = TextEditingController();

  // final deleteUrl =
  // void deletePost(Post post, int index) {
  //   ApiServices.deletePost(
  //       id: widget.post.id,
  //       context: context,
  //       onSuccess: () {
  //         post.images!.removeAt(index);
  //         setState(() {});
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    // int index;
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              if (CurrentUser.userId != widget.post.author.id) {
                Get.to(
                    () => ViewUserProfile(
                          user: widget.post.author,
                        ),
                    arguments: widget.post,
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 250));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const ViewUserProfile(),
                //       settings: RouteSettings(arguments: widget.post)),
                // );
              } else {
                print('go to curren user account');
              }
            },
            child: ProfileAvatar(
                imageUrl: widget.post.author.profileImage!, radius: 20)),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => print('go to  profile '),
                child: Text(
                  widget.post.author.username,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(widget.post.date),
            ],
          ),
        ),

        // print(post.id);
        // await RestApiService.delete(ApiPaths.deletePosts + '/${post.id}');
        // print('entered1');
        // Map<String, String> map = RestApiService.apiHeaders;
        // final url = Uri.parse(
        //     'https://${ApiPaths.baseUrl}${ApiPaths.deletePosts}/${post.id}');
        // try {
        //   print('entered try');
        //   http.Response res =
        //       await http.put(url, headers: map, body: data);
        //   print('after put request');

        //   // await RestApiService.put(
        //   //     ApiPaths.deletePosts + '/${post.id}', data);
        // } catch (e) {
        //   print(e.toString());
        // }

        widget.post.author.id == CurrentUser.userId
            ? FocusedMenu(
                widget: const Icon(Icons.more_horiz),
                backgroundColor1: Colors.transparent,
                backgroundColor2: Colors.red,
                fnc1: () {
                  // return ApiServices.editPost(post.id, data);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Edit post',
                                textAlign: TextAlign.center),
                            content: TextFormField(
                              validator: ((value) {
                                if (value!.isEmpty ||
                                    value.characters.length < 9) {
                                  return 'Post has least 10 characters';
                                }
                              }),
                              controller: _editPostController,
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'Type your new description!',
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Map data = {
                                      'text': _editPostController.text,
                                    };
                                    if (_editPostController.text.trim().length >
                                        9) {
                                      Navigator.pop(context);
                                      ApiServices.editPost(
                                          id: widget.post.id,
                                          data: data,
                                          context: context);
                                    }
                                  },
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: _editPostController.text
                                                  .trim()
                                                  .length >
                                              9
                                          ? AppColors.secondary
                                          : Colors.grey,
                                    ),
                                  ))
                            ],
                          ));
                },
                fnc2: () {
                  // widget.post.removeAt(index);
                  setState(() {
                    ApiServices.deletePost(
                        id: widget.post.id, context: context);
                  });
                },
                title1: 'Edit',
                title1Color: AppColors.textDark,
                title2: 'Delete',
                title2Color: Colors.white,
                icon1: Icons.edit,
                icon1Color: AppColors.secondary,
                icon2: Icons.delete,
                icon2Color: Colors.white,
              )
            : FocusedMenu(
                widget: const Icon(Icons.more_horiz),
                backgroundColor1: Colors.transparent,
                backgroundColor2: Colors.red,
                fnc1: () {
                  // return ApiServices.editPost(post.id, data);
                  ApiServices.followUnfollow(
                      context: context, userId: widget.post.author.id);
                },
                fnc2: () {
                  print('report account');
                  // widget.post.removeAt(index);
                },
                title1: 'Follow account',
                title2Color: Colors.white,
                title2: 'Report',
                title1Color: AppColors.textDark,
                icon2: Icons.flag,
                icon1Color: AppColors.secondary,
                icon1: Icons.person_add,
                icon2Color: Colors.white,
              )
      ],
    );
  }
}

// Future getUserDetails() async {
//   try {
//     final response = await RestApiService.get(
//         ApiPaths.baseUrl + ApiPaths.getUsers + '/' + AuthRepository.token!,
//         RestApiService.apiHeaders);
//     dynamic tokenBody = response.body;
//     jsonDecode(tokenBody['username']);
//     print(tokenBody);
//   } catch (e) {
//     print('sdkfjbdsfhbdsfbsdkbfdkjbfskjdfbsdkjbfkjsdbfdksjbfskdfbkdfbkjbsdf');
//   }
//   ;
// }

class _PostStats extends StatelessWidget {
  final Post post;
  const _PostStats({
    super.key,
    required this.post,
  });

  // void addLikes(BuildContext context) async {
  //   try {
  //     String id = post.id.trim();
  //     final headers = {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${AuthRepository.token}',
  //     };
  //     final url = Uri.parse(
  //         'https://animebe-production.up.railway.app/api/posts/$id/like');

  //     var res = await http.patch(url, headers: headers);

  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onSuccess: () {
  //           displayDeleteMotionToast(
  //               context: context,
  //               description: 'Like has been added successfully',
  //               msg: 'Like');
  //           // Navigator.pop(context);
  //         });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var data = {"text": "string", "replayTo": {}};
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InteractButton(
              post: post,
              isLikedColor: Colors.red,
              isNotLikedColor: Colors.black54,
              initialAnimateColor: Colors.redAccent,
              endAnimateColor: const Color(0xff00ddff),
              isLikedIcon: Icons.favorite,
              isNotLikedIcon: Icons.favorite_border,
              size: 25,
              interactiCount: post.likes!.length,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),

            IconButton(
                onPressed: () {
                  Get.to(() => const CommentsPage(),
                      arguments: post,
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 250));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (builder) => const CommentsPage(),
                  //     settings: RouteSettings(arguments: post),
                  //   ),
                  // );
                },
                icon: const Icon(
                  FeatherIcons.messageCircle,
                  color: Colors.black54,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.009,
            ),
            IconButton(
              onPressed: () {
                ApiServices.addLikes(context: context, id: post.id);
                // ApiServices.addComment(
                //     context: context,
                //     text: 'First Comment',
                //     postId: post.id,
                //     authorId: post.author.id)
              },
              icon: const Icon(
                FeatherIcons.send,
                color: Colors.black54,
              ),
            ),
            // Text(
            //   'Share',
            //   style: GoogleFonts.poppins(),
            // ),
            const Spacer(),
            InteractButton(
              post: post,
              isLikedColor: Colors.yellow,
              isNotLikedColor: Colors.black54,
              initialAnimateColor: Colors.yellowAccent,
              endAnimateColor: Colors.yellow,
              isLikedIcon: Icons.bookmark,
              isNotLikedIcon: Icons.bookmark_border_outlined,
              size: 25,
              interactiCount: 100,
            ),
          ],
        )
      ],
    );
  }
}

class PostImage extends StatelessWidget {
  final Post post;
  const PostImage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: post.images!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CarouselSlider(
                items: post.images!.map(
                  (url) {
                    return Builder(
                      builder: (BuildContext context) => CachedNetworkImage(
                        imageUrl: url,
                        filterQuality: FilterQuality.high,
                        // fit: BoxFit.contain,
                        // height: double.infinity,
                      ),
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  // aspectRatio: 16 / 9,

                  // reverse: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  // height: 200,
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class ViewPost extends StatelessWidget {
  final Post post;
  const ViewPost({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Your posts',
            style: TextStyle(color: AppColors.textDark),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.iconDark,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          color: Colors.white,

          // to add padding to the entire post including the images
          //add wrap the container with padding instead of the column

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 10),
                child: Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PostHeader(post: post),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            post.text,
                          ),
                        ),
                        post.images!.isNotEmpty
                            ? const SizedBox.shrink()
                            : const SizedBox(
                                height: 6.0,
                              ),
                      ]),
                ),
              ),
              // post.author.id == CurrentUser.userId
              // ?
              post.images!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CarouselSlider(
                        items: post.images!.map(
                          (url) {
                            return Builder(
                              builder: (BuildContext context) =>
                                  CachedNetworkImage(
                                imageUrl: url,
                                filterQuality: FilterQuality.high,
                                // fit: BoxFit.contain,
                                // height: double.infinity,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          // aspectRatio: 16 / 9,

                          // reverse: true,
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                          // height: 200,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              // : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: _PostStats(post: post),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DiscussionPosts extends StatelessWidget {
  final Post post;
  const DiscussionPosts({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,

      // to add padding to the entire post including the images
      //add wrap the container with padding instead of the column

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 10),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PostHeader(post: post),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      post.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // post.author.id == CurrentUser.userId
          // ?

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _PostStats(post: post),
          )
        ],
      ),
    );
  }
}
