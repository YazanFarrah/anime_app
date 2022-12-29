import 'dart:convert';

import 'package:anime_app/core/utils.dart';
import 'package:anime_app/features/auth/screens/profile_screen.dart';
import 'package:anime_app/models/current_user.dart';
import 'package:anime_app/models/post.dart';
import 'package:anime_app/network/remote/api_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../widgets/icon-buttons.dart';
import '../../../../models/user.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/api-paths.dart';
import '../../../../utils/rest-api-service.dart';
import '../../../../widgets/navigate.dart';
import '../../../../widgets/post_container.dart';
import '../../../../widgets/profile_clipper.dart';

class ViewUserProfile extends StatefulWidget {
  final User user;
  const ViewUserProfile({
    super.key,
    required this.user,
  });

  @override
  State<ViewUserProfile> createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  String text = 'Follow';
  @override
  Widget build(BuildContext context) {
    // final userFromPost = ModalRoute.of(context)!.settings.arguments as Post;
    // print(
    //     '///////////////// ${widget.user.followers.contains(CurrentUser.userId)}');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
          centerTitle: true,
          title: Center(
            child: Text(
              //username
              widget.user.username.capitalize(),
              style: GoogleFonts.lobster(
                fontSize: 20,
                color: const Color(0xff2E99C7),
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: IconBackground(
                icon: Icons.more,
                onTap: () {},
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: ProfileClipper(),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1578632749014-ca77efd052eb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGFuaW1lfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                    height: MediaQuery.of(context).size.height * 0.265,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 3.0, color: Colors.blue),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0)
                      ],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        height: 120,
                        imageUrl:
                            'https://i.pinimg.com/236x/81/70/21/81702128c4248529f9dc6e7506432004.jpg',
                        fit: BoxFit.cover,
                        width: 120,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              widget.user.username.capitalize(),
              style: GoogleFonts.lobster(
                fontSize: 30,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IconButton(
                //     onPressed: () => print(user.author.followers.length),
                //     icon: Icon(Icons.taxi_alert)),
                ProfileColumnWidget(
                    text: 'Followers',
                    text2: widget.user.followers.length.toString()),
                const SizedBox(
                  width: 20,
                ),
                ProfileColumnWidget(
                  text: 'Following',
                  text2: widget.user.followings.length.toString(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        elevation: 8,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        backgroundColor: Colors.white,
                        // side: BorderSide(
                        //   width: 1,
                        //   color: Colors.grey,
                        // ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (widget.user.followers
                              .contains(CurrentUser.userId)) {
                            text = 'Unfollow';
                          } else {
                            text = 'Follow';
                          }

                          // text = user.author.followers
                          //             .contains(CurrentUser.userId) !=
                          //         true
                          //     ? 'Follow'
                          //     : 'Unfollow';
                        });
                        ApiServices.followUnfollow(
                            context: context, userId: widget.user.id);
                        // CurrentUser.following.contains(user.author.id)
                      },
                      child: Text(
                        text,

                        // user.author.followers.contains(CurrentUser.userId) == true
                        //     ? 'Unfollow'
                        //     : 'Follow',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        elevation: 8,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        backgroundColor: Colors.white,
                        // side: BorderSide(
                        //   width: 1,
                        //   color: Colors.grey,
                        // ),
                      ),
                      onPressed: () => print('message'),
                      child: const Text(
                        'Message',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: AppColors.secondary,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.grid_3x3,
                    color: Colors.black54,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person_2_outlined,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UsersPostsTap(user: widget.user),
                  UsersDiscussionTap(user: widget.user),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsersPostsTap extends StatefulWidget {
  final User user;
  const UsersPostsTap({
    super.key,
    required this.user,
  });

  @override
  State<UsersPostsTap> createState() => _UsersPostsTapState();
}

class _UsersPostsTapState extends State<UsersPostsTap> {
  List<Post> post = [];

  // Post? posts;
  _getData() async {
    try {
      var res = await RestApiService.get(ApiPaths.getPosts);

      // post = (jsonDecode(res.body) as List).map((json) {
      //   if (json['author']['_id'] == CurrentUser.userId) {
      //     return Post.fromJson(json);
      //   }
      // }).toList();
      // print(res.body);
      (jsonDecode(res.body) as List).forEach((json) {
        // print('Json Author');
        // print(json['author']['_id']);
        // print('Current UIser');

        if (widget.user.id == json['author']['_id'].toString() &&
            json['images'].isNotEmpty) {
          // print(json['images']);
          post.add(Post.fromJson(json));
        }
      });

      print(post.length);

      return post;
    } catch (e) {
      print(e.toString());
    }
  }

  // Future refresh() async {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) => GridView.builder(
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: post.length,
        itemBuilder: (context, int index) {
          if (snapshot.hasData) {
            // print(post[index]!.images.length);
            // return Container(
            //   child:
            //       Image(image: NetworkImage(post[index].images.toString())),
            // );
            // int length;
            // for (int i= 0; i < length; i

            return Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => ViewPost(post: post[index]),
                      )),
                  child: Container(
                      child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(post[index].images![0]),
                  )
                      // PostImage(post: post[index]),
                      ),
                ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox.shrink();

          // return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class UsersDiscussionTap extends StatefulWidget {
  final User user;
  const UsersDiscussionTap({
    super.key,
    required this.user,
  });

  @override
  State<UsersDiscussionTap> createState() => _UsersDiscussionTapState();
}

class _UsersDiscussionTapState extends State<UsersDiscussionTap> {
  List<Post> post = [];

  _getData() async {
    try {
      var res = await RestApiService.get(ApiPaths.getPosts);
      // print(res.body);
      (jsonDecode(res.body) as List).forEach((json) {
        // print('Json Author');
        // print(json['author']['_id']);
        // print('Current UIser');

        if (widget.user.id == json['author']['_id'].toString() &&
            json['images'].isEmpty) {
          post.add(Post.fromJson(json));
        }
      });
      print(post);

      return post;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) => ListView.builder(
        itemCount: post.length,
        itemBuilder: (context, int index) {
          if (snapshot.hasData) {
            if (post[index].author.id == CurrentUser.userId &&
                post[index].images!.isEmpty) {
              return DiscussionPosts(post: post[index]);
            } else {
              const SizedBox.shrink();
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox.shrink();

          // return const CircularProgressIndicator();
        },
      ),
    );
  }
}
