import 'dart:io';
import 'package:anime_app/features/auth/screens/screens.dart';
import 'package:anime_app/network/remote/api_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';
import '../../../utils/utils.dart';

class AddPost extends StatefulWidget {
  static const String routName = '/add-post';

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController descriptionController = TextEditingController();
  // final AdminServices adminServices = AdminServices();

  String category = 'Action';
  List<File> image = [];
  List<File> video = [];
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
        (image.isNotEmpty || video.isNotEmpty)) {
      ApiServices.createPost(
          context: context,
          // name: ,
          description: descriptionController.text,
          category: category,
          image: image,
          video: video);
    }
  }

  void selectPhoto() async {
    var res = await pickImage();
    setState(() {
      image = res;
    });
  }

  void selectVideo() async {
    var res = await pickVideo();
    setState(() {
      video = res;
    });
  }

  // Uint8List? _file;
  // final TextEditingController _descriptionController = TextEditingController();
  //

  // void postImage(
  //   String uid,
  //   String username,
  //   String profImage,
  //   Uint8List? _file,
  //   String description,
  // ) async {
  //   print('entered');
  //   final url = Uri.parse(
  //       'https://animeproject-6bd77-default-rtdb.firebaseio.com/posts.json');
  //   var response = await http.post(url,
  //       body: json.encode(
  //         {
  //           'uid': uid,
  //           'username': username,
  //           'profImage': profImage,
  //           // 'file': _file,
  //           'description': description,
  //         },
  //       ));
  //   print(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Pallete.greyColor,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavScreen(),
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: postPost,
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Pallete.greyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
        centerTitle: true,
        title: const Text(
          'Add a post',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _addPostFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Type a caption'),
                    controller: descriptionController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      image.isNotEmpty
                          ? CarouselSlider(
                              items: image.map(
                                (i) {
                                  return Builder(
                                    builder: (BuildContext context) =>
                                        Image.file(
                                      i,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    ),
                                  );
                                },
                              ).toList(),
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: 200,
                              ),
                            )
                          : ElevatedButton.icon(
                              onPressed: selectPhoto,
                              icon: const Icon(Icons.upload),
                              label: const Text('Upload'),
                            ),
                      video.isNotEmpty
                          ? Text('data')
                          : ElevatedButton.icon(
                              onPressed: selectVideo,
                              icon: const Icon(Icons.upload),
                              label: const Text('Upload video'),
                            ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: postCategories.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
