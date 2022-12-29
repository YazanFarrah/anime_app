// import 'package:country_list_pick/country_list_pick.dart';
import 'package:anime_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/widgets.dart';
import '../../../network/remote/auth-repository.dart';
import '../screens/screens.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final AuthRepository authService = AuthRepository();
  final FocusNode _focusNode = FocusNode();

  // @override
  @override
  Widget build(BuildContext context) {
    RegExp passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(20.0));
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SizedBox(
            // padding: deviceSize.width > webScreenSize
            //     ? EdgeInsets.symmetric(horizontal: deviceSize.width / 3)
            //     : const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //name image
                  const SizedBox(height: 20),
                  Text(
                    'Name',
                    style: GoogleFonts.lobster(
                        fontSize: 60, color: const Color(0xff2E99C7)),
                  ),
                  SizedBox(height: deviceSize.height * 0.1),

                  //text field input for full name

                  //text field input for username

                  SizedBox(
                    width: deviceSize.width * 0.9,
                    child: TextFieldInput(
                        fieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return AppLocalizations.of(context)!.validUsername;
                          } else {
                            return null;
                          }
                        },
                        textEditingController: _usernameController,
                        hintText: AppLocalizations.of(context)!.username,
                        textInputType: TextInputType.text),
                  ),

                  //text field input for email

                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width: deviceSize.width * 0.9,
                    child: TextFieldInput(
                        focusNode: _focusNode,
                        validator: (value) {
                          // for example a.aaba@a1aa_a.com .io .store .ex {2,4}
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                                  .hasMatch(value!)) {
                            return AppLocalizations.of(context)!.validEmail;
                          } else {
                            return null;
                          }
                        },
                        textEditingController: _emailController,
                        hintText: AppLocalizations.of(context)!.email,
                        textInputType: TextInputType.emailAddress),
                  ),

                  SizedBox(
                    height: deviceSize.height * 0.05,
                  ),

                  //text field input for password

                  //login button

                  SizedBox(
                    width: deviceSize.width * 0.9,
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.signUp,
                          style: GoogleFonts.lobster(
                              fontSize: 40, color: const Color(0xff2E99C7)),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xff2E99C7),
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  navPush(
                                    context,
                                    BirthdaySelect(
                                      email: _emailController.text,
                                      username: _usernameController.text,
                                    ),
                                  );
                                } else {}
                              },
                              icon: const Icon(
                                Icons.arrow_forward,
                              )),
                        ),
                      ],
                    ),
                  ),

                  //forgot password button

                  SizedBox(
                    height: deviceSize.width * 0.72,
                  ),

                  SizedBox(
                    width: deviceSize.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            AppLocalizations.of(context)!.oldUser,
                            style: const TextStyle(
                              color: Color(0xff4c505b),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: TextButton(
                            // onLongPress: _switchAuthMode,
                            onPressed: () {
                              navPushReplacement(context, MyLogin());
                            },
                            child: Text(
                              AppLocalizations.of(context)!.logIn,
                              style: const TextStyle(
                                  color: Color(0xff2E99C7),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
