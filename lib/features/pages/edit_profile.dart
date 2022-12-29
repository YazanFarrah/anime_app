import 'dart:io';

import 'package:anime_app/models/current_user.dart';
import 'package:anime_app/network/remote/api_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<File> image = [];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final _EditProfileFormKey = GlobalKey<FormState>();
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();

    super.dispose();
  }

  void selectMedia() async {
    var res = await pickImage();
    setState(() {
      image = res;
    });
  }

  void selectPhoto() async {
    var res = await pickImage();
    setState(() {
      image = res;
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        const Text('Choose profile photo'),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              label: const Text('Camera'),
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            TextButton.icon(
              label: const Text('Gallery'),
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        )
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
              color: Colors.grey,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  CurrentUser.profileImage = _imageFile!.path;
                },
                icon: const Icon(
                  Icons.check,
                  size: 30,
                  color: Color(0xff2E99C7),
                ))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: GoogleFonts.lobster(
                fontSize: 35, color: const Color(0xff2E99C7)),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _EditProfileFormKey,
            child: Column(
              children: [
                const Divider(
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (builder) => bottomSheet()),
                          child: CircleAvatar(
                            backgroundImage: _imageFile == null
                                ? const NetworkImage(
                                        'https://i.pinimg.com/236x/81/70/21/81702128c4248529f9dc6e7506432004.jpg')
                                    as ImageProvider
                                : FileImage(File(_imageFile!.path)),
                            radius: 50,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const Text(
                          'Change profile photo',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () => ApiServices.patchAnimefan(
                                  context: context,
                                ),
                            icon: const Icon(Icons.health_and_safety))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                textField(controller: emailController, hintText: 'Email'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                textField(controller: usernameController, hintText: 'Username'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class textField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const textField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            // border: OutlineInputBorder(),
            hintText: hintText),
      ),
    );
  }
}
