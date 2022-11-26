// import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/widgets.dart';
import '../../../network/remote/auth-repository.dart';
import '../screens/screens.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final AuthRepository authService = AuthRepository();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      username: _usernameController.text,
      birthday: '12-28-2022',
      // name: _nameController.text,
      // username: _usernameController.text,
    );
  }

  // @override
  @override
  Widget build(BuildContext context) {
    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    //saving email, password

    RegExp passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(20.0));
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Container(
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
                  const SizedBox(height: 40),

                  //text field input for full name

                  TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your name';
                        } else {
                          return null;
                        }
                      },
                      textEditingController: _nameController,
                      hintText: 'Full name',
                      textInputType: TextInputType.text),

                  const SizedBox(
                    height: 20,
                  ),

                  //text field input for username

                  TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter username';
                        } else {
                          return null;
                        }
                      },
                      textEditingController: _usernameController,
                      hintText: 'Username',
                      textInputType: TextInputType.text),

                  //text field input for email

                  const SizedBox(
                    height: 20,
                  ),

                  TextFieldInput(
                      validator: (value) {
                        // for example a.aaba@a1aa_a.com .io .store .ex {2,4}
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                                .hasMatch(value!)) {
                          return 'Enter valid email';
                        } else {
                          return null;
                        }
                      },
                      textEditingController: _emailController,
                      hintText: 'Email',
                      textInputType: TextInputType.emailAddress),

                  const SizedBox(
                    height: 20,
                  ),

                  //text field input for password

                  TextFieldInput(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password must be 8-20 letters\nat least 1 number and 1 symbol';
                      } else {
                        if (!passwordRegExp.hasMatch(value)) {
                          return 'Enter valid password';
                        } else {
                          return null;
                        }
                      }
                    },
                    textEditingController: _passwordController,
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //confirm password

                  TextFormField(
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          filled: true,
                          enabledBorder: inputBorder,
                          contentPadding: const EdgeInsets.all(15),
                          labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text ||
                            value!.isEmpty) {
                          return 'Passwords do not match!';
                        }
                        return null;
                      }),

                  const SizedBox(
                    height: 20,
                  ),

                  //country picker

                  // Container(
                  //   child: CountryListPick(
                  //     theme: CountryTheme(
                  //       isShowFlag: true,
                  //       isShowTitle: true,
                  //       isShowCode: false,
                  //       isDownIcon: true,
                  //       showEnglishName: true,
                  //       labelColor: Color(0xff2E99C7),
                  //     ),
                  //   ),
                  // ),

                  //login button

                  Row(
                    children: [
                      Text(
                        'Sign Up',
                        style: GoogleFonts.lobster(
                            fontSize: 40, color: const Color(0xff2E99C7)),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xff2E99C7),
                        child: IconButton(
                            color: Colors.white,
                            onPressed: signUpUser,

                            // navPushReplacement(context, MyLogin()),

                            icon: const Icon(
                              Icons.arrow_forward,
                            )),
                      ),
                    ],
                  ),

                  //forgot password button

                  const SizedBox(
                    height: 20,
                  ),

                  //already have an account?

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Already have an acoount?",
                          style: TextStyle(
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MyLogin(),
                              ),
                            );
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                                color: Color(0xff2E99C7),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
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
