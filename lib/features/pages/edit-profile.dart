import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<File> image = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final _EditProfileFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void selectMedia() async {
    var res = await pickImage();
    setState(() {
      image = res;
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
                onPressed: () {},
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
                          onTap: () => print('change photo'),
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://t3.ftcdn.net/jpg/01/67/26/42/240_F_167264239_MJTYeDoQEItDJqlhVV13VVdQ94ViScwe.jpg'),
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
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => print('change video'),
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://vectorified.com/images/film-icon-6.png'),
                            backgroundColor: Colors.grey,
                            radius: 50,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const Text('Change video',
                            style: TextStyle(fontSize: 16)),
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
                textField(controller: nameController, hintText: 'Name'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                textField(controller: usernameController, hintText: 'Username'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                textField(controller: bioController, hintText: 'bio'),
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
