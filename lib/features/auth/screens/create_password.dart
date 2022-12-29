import 'package:anime_app/features/auth/screens/login-screen.dart';
import 'package:anime_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../network/remote/auth-repository.dart';
import '../../../theme/theme.dart';
import '../../../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CreatePassword extends StatefulWidget {
  final String email;
  final String username;
  final String birthday;
  const CreatePassword({
    super.key,
    required this.email,
    required this.username,
    required this.birthday,
  });

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthRepository authService = AuthRepository();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  RegExp passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  void signUpUser(BuildContext context) {
    authService.signUpUser(
      context: context,
      email: widget.email,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      username: widget.username,
      birthday: widget.birthday,
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(20.0));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColors.iconLight,
          ),
          title: Text(
            AppLocalizations.of(context)!.createPass,
            style:
                GoogleFonts.lobster(color: AppColors.secondary, fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _passwordFormKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
              child: Column(children: [
                //text field input for password

                TextFormField(
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_focusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty || !passwordRegExp.hasMatch(value)) {
                      return AppLocalizations.of(context)!.validPassword;
                    } else {
                      return null;
                    }
                  },
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: this._showPassword ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(
                            () => this._showPassword = !this._showPassword);
                      },
                    ),
                    border: inputBorder,
                    focusedBorder: inputBorder,
                    filled: true,
                    enabledBorder: inputBorder,
                    contentPadding: const EdgeInsets.all(15),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: !this._showPassword,
                ),

                const SizedBox(
                  height: 20,
                ),
                //confirm password

                TextFormField(
                    focusNode: _focusNode,
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.security),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: this._showConfirmPassword
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() => this._showConfirmPassword =
                                !this._showConfirmPassword);
                          },
                        ),
                        border: inputBorder,
                        focusedBorder: inputBorder,
                        filled: true,
                        enabledBorder: inputBorder,
                        contentPadding: const EdgeInsets.all(15),
                        labelText:
                            AppLocalizations.of(context)!.confirmPassword),
                    obscureText: !this._showConfirmPassword,
                    validator: (value) {
                      if (value != _passwordController.text || value!.isEmpty) {
                        return AppLocalizations.of(context)!.passdontMatch;
                      }
                      return null;
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.proceedToLogin,
                      style: GoogleFonts.lobster(
                          color: AppColors.secondary, fontSize: 25),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff2E99C7),
                      child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            if (_passwordFormKey.currentState!.validate()) {
                              print(widget.username);
                              print(widget.email);
                              print(widget.birthday);

                              signUpUser(context);
                              // navPushReplacement(context, MyLogin());
                            }
                          },

                          // navPushReplacement(context, MyLogin()),

                          icon: const Icon(
                            Icons.arrow_forward,
                          )),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
