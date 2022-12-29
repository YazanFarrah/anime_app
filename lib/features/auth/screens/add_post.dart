import 'dart:io';
import 'package:anime_app/features/auth/screens/home_screen.dart';
import 'package:anime_app/features/auth/screens/screens.dart';
import 'package:anime_app/models/current_user.dart';
import 'package:anime_app/network/remote/api_services.dart';
import 'package:anime_app/theme/theme.dart';
import 'package:anime_app/widgets/buttons/dialog_button.dart';
import 'package:anime_app/widgets/motion_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:video_player/video_player.dart';

import '../../../theme/pallete.dart';
import '../../../utils/utils.dart';

class AddPost extends StatefulWidget {
  static const String routName = '/add-post';

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // String category = 'Action';
  List<File> image = [];
  List<File> photo = [];
  List<File> video = [];
  bool _loading = false;
  bool _buttonEnabled = true;
  final _addPostFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  List<String> postCategories = [
    'Action',
    'Drama',
    'Meme',
    'Spoiler!',
  ];

  void postPost() {
    if (_addPostFormKey.currentState!.validate() &&
        (image.isNotEmpty ||
            video.isNotEmpty ||
            descriptionController.text.length > 9)) {
      ApiServices.createPost(
        context: context,
        // name: ,
        description: descriptionController.text,
        image: image,
      );
    }
  }

  void selectPhoto() async {
    var res = await pickImage();
    setState(() {
      image = res;
    });
  }

  void capturePhoto() async {
    photo = (await _picker.pickImage(source: ImageSource.camera)) as List<File>;
    if (photo != null) {
      setState(() {
        image.addAll(photo);
      });
    }
  }

  void selectVideo() async {
    var res = await pickVideo();
    setState(() {
      video = res;
    });
  }

  void clear() {
    image.clear();
    descriptionController.clear();
    video.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: descriptionController.text.trim().isNotEmpty ||
                image.isNotEmpty ||
                video.isNotEmpty
            ? DialogBtn(
                btn1Function: () {
                  clear();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                btn2Function: () => Navigator.pop(context),
                context: context,
                icon1: Icons.check,
                icon1Color: Colors.green,
                icon2: Icons.cancel,
                icon2Color: Colors.black,
                iconText1Color: Colors.green,
                iconText2Color: Colors.black,
                message: 'Cancel',
                mainIcon: Icons.arrow_back_ios,
                text1: 'Yes',
                text2: 'No',
                title: 'Cancel Post',
                mainIconColor: AppColors.iconLight,
              )
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
                color: AppColors.iconLight,
              ),
        //   Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const NavScreen(),
        //   ),
        // );

        actions: [
          TextButton(
              onPressed: _buttonEnabled
                  ? () {
                      if (descriptionController.text.length < 9) {
                        displayWarningMotionToast(
                            context, 'Enter at least 10 characters', 'Warning');
                      } else {
                        setState(() {
                          _buttonEnabled = false;
                          _loading = true;
                        });
                        postPost();
                      }
                    }
                  : null,
              child: _loading
                  ? const CircularProgressIndicator(
                      color: AppColors.secondary,
                    )
                  : Text(
                      'Post',
                      style: TextStyle(
                        color: descriptionController.text.isEmpty
                            ? Colors.grey
                            : AppColors.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
        ],
        centerTitle: true,
        title: const Text(
          'Add a post',
          style: TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
          key: _addPostFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(
                            'CurrentUser.profileImage! as String')),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.length < 10) {
                            displayWarningMotionToast(context,
                                'Enter at least 10 characters', 'Warning');
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: 'Type a caption',
                            border: InputBorder.none),
                        controller: descriptionController,
                        maxLines: 8,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CarouselSlider(
                        items: image.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.fill,
                                // height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          // reverse: true,
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                          // height: 200,
                          // disableCenter: true,
                          aspectRatio: 4 / 3,
                        ),
                      ),
                    )
                  ],
                ),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),

                // const Flexible(
                //   flex: 2,
                //   child: SizedBox.shrink(),
                // ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => capturePhoto(),
                      icon: const Icon(FeatherIcons.camera),
                      iconSize: 25,
                    ),
                    IconButton(
                      onPressed: () => selectPhoto(),
                      icon: const Icon(FeatherIcons.image),
                      iconSize: 25,
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(FeatherIcons.video),
                    //   iconSize: 25,
                    // ),
                  ],
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: DropdownButton(
                //     value: category,
                //     icon: const Icon(Icons.keyboard_arrow_down),
                //     items: postCategories.map((String item) {
                //       return DropdownMenuItem(
                //         value: item,
                //         child: Text(item),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         category = newValue!;
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}
