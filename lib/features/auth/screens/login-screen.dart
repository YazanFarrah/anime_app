import 'package:anime_app/network/remote/auth-repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants.dart';
import '../../../widgets/widgets.dart';
import '../../pages/forgot_password_otp.dart';
import 'screens.dart';
import 'sign_up_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class MyLogin extends StatefulWidget {
  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final AuthRepository authService = AuthRepository();

  final FocusNode _focusedNode = FocusNode();

  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();
    super.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  // @override
  @override
  Widget build(BuildContext context) {
    bool _isVisible = true;

    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(20.0));
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //name image
                    const SizedBox(height: 64),

                    Text(
                      'Name',
                      style: GoogleFonts.lobster(
                          fontSize: 60, color: const Color(0xff2E99C7)),
                    ),
                    const SizedBox(height: 64),

                    //text field input for email

                    SizedBox(
                      width: deviceSize.width * 0.9,
                      child: TextFieldInput(
                        fieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focusedNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)!.plsEnteremail;
                          }
                        },
                        textEditingController: _emailController,
                        hintText:
                            AppLocalizations.of(context)!.usernameEmailText,
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //text field input for password

                    SizedBox(
                      width: deviceSize.width * 0.9,
                      child: TextFormField(
                        focusNode: _focusedNode,
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        obscureText: !this._showPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.plsEnterPass;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          hintText: AppLocalizations.of(context)!.enterPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: this._showPassword
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() =>
                                  this._showPassword = !this._showPassword);
                            },
                          ),
                          border: inputBorder,
                          enabledBorder: inputBorder,
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //login button

                    SizedBox(
                      width: deviceSize.width * 0.9,
                      child: Row(
                        children: [
                          //login text
                          Text(
                            AppLocalizations.of(context)!.logIn,
                            style: GoogleFonts.lobster(
                                fontSize: 30, color: const Color(0xff2E99C7)),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xff2E99C7),
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () => signInUser(),
                                // navPushReplacement(context, MyLogin()),

                                icon: const Icon(
                                  Icons.arrow_forward,
                                )),
                          ),
                        ],
                      ),
                    ),

                    //forgot password button
                    const SizedBox(
                      height: 20,
                    ),
                    //forgot password textButton
                    TextButton(
                      onPressed: () {
                        navPush(context, const OtpForm());
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgotPass,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xff4c505b),
                          fontSize: 18,
                        ),
                      ),
                    ),

                    // Flexible(child: Container(), flex: 2),

                    //already have an account?
                    SizedBox(
                      height: deviceSize.height * 0.26,
                    ),
                    SizedBox(
                      width: deviceSize.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              AppLocalizations.of(context)!.newUser,
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
                                navPushReplacement(context, SignUpScreen());
                              },
                              child: Text(
                                AppLocalizations.of(context)!.signUpBtn,
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
      ),
    );
  }
}

// void _openPopup(context) {
//   final deviceSize = MediaQuery.of(context).size;
//   showModalBottomSheet(
//     backgroundColor: Colors.white,
//     isScrollControlled: true,
//     context: context,
//     builder: (context) => SizedBox(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Center(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(
//                       Icons.close,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.1,
//               ),
//               Container(
//                 alignment: Alignment.bottomCenter,
//                 child: Text(
//                   'Sign up',
//                   style: GoogleFonts.lobster(
//                     fontSize: 60.0,
//                     color: const Color(0xff2E99C7),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.15,
//               ),
//               SizedBox(
//                 width: deviceSize.width * 0.8,
//                 height: 50,
//                 child: TextButton.icon(
//                     style: TextButton.styleFrom(
//                         backgroundColor: const Color(0xFF2E99C7),
//                         elevation: 8.0),
//                     onPressed: () =>
//                         navPushReplacement(context, SignUpScreen()),
//                     icon: const Icon(Icons.person_outline, color: Colors.white),
//                     label: const Text(
//                       'Sign up with email',
//                       style: TextStyle(color: Colors.white),
//                     )),
//               ),
//               const SizedBox(
//                 height: 15.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Text('OR'),
//                 ],
//               ),
//               const SizedBox(
//                 height: 15.0,
//               ),
//               SizedBox(
//                 width: deviceSize.width * 0.8,
//                 height: 50,
//                 child: TextButton.icon(
//                     style: TextButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         padding: const EdgeInsets.only(left: 20),
//                         elevation: 8.0),
//                     onPressed: () {},
//                     icon: const Icon(Icons.facebook, color: Colors.blue),
//                     label: const Text(
//                       'Sign up with Facebook',
//                       style: TextStyle(color: Colors.black),
//                     )),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               SizedBox(
//                 width: deviceSize.width * 0.8,
//                 height: 50,
//                 child: TextButton.icon(
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white, elevation: 8.0),
//                   onPressed: () {},
//                   icon: const Icon(Icons.apple, color: Colors.black),
//                   label: const Text(
//                     'Sign up with Apple',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               SizedBox(
//                 width: deviceSize.width * 0.8,
//                 height: 50,
//                 child: TextButton.icon(
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white, elevation: 8.0),
//                   onPressed: () {},
//                   icon: Image.asset(
//                     Constants.googlePath,
//                   ),
//                   label: const Text(
//                     'Sign up with google',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               SizedBox(
//                 width: deviceSize.width * 0.8,
//                 height: 50,
//                 child: TextButton.icon(
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white, elevation: 8.0),
//                   onPressed: () {},
//                   icon: const FaIcon(
//                     FontAwesomeIcons.twitter,
//                     color: Colors.blue,
//                   ),
//                   label: const Text(
//                     'Sign up with twitter',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 const Text(
//                   'Already have an account?',
//                   style: TextStyle(
//                     color: Color(0xff4c505b),
//                     fontSize: 18,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text(
//                     'Log in',
//                     style: TextStyle(
//                       color: Color(0xff2E99C7),
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ]),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
