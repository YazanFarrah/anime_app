import 'package:anime_app/utils/api-paths.dart';
import 'package:anime_app/utils/rest-api-service.dart';
import 'package:anime_app/widgets/loader.dart';
import 'package:anime_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:anime_app/models/models.dart';

import '../../core/utils.dart';
import '../../features/auth/screens/screens.dart';
import '../../widgets/motion_toast.dart';
import '../local/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AuthRepository {
  static String? token;
  static String id = '';
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
    required String birthday,
    // required String name,
    // required String username,
  }) async {
    try {
      print('in sign up');
      // User user = User(
      //   id: '',
      //   name: 'name',
      //   password: password,
      //   email: email,

      //   token: '',
      //   // cart: [],
      // );
      // final String formattedDate =
      //     DateFormat.yMd().format(DateTime(1999, 8, 25));
      final data = {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'username': username,
        'birthday': birthday,
      };

      var res = await RestApiService.post(
        ApiPaths.signUp,
        data,
      );
      print(res.statusCode);
      print(data);
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // CacheHelper.setString(key: 'userId', value: res.body);
          // print(res.body);
          displaySuccessMotionToast(
            context,
            AppLocalizations.of(context)!.accountcreated,
            AppLocalizations.of(context)!.loginWithsameInfo,
          );
          Future.delayed(const Duration(seconds: 2)).then(
            (value) {
              navPushReplacement(context, MyLogin());
            },
          );
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var data = {
        'email': email,
        'password': password,
      };
      // print('i');
      var res = await RestApiService.post(
        ApiPaths.logIn,
        data,
      );
      print(res.body);
      print(res.statusCode);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            CacheHelper.setString(
                key: 'token', value: jsonDecode(res.body)['token']);
            print(jsonDecode(res.body));
            // print(res.body);
            navPushReplacement(context, const NavScreen());
          }

          // () async {
          //   SharedPreferences prefs = await SharedPreferences.getInstance();
          //   // Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          //   await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          //   // Navigator.pushNamedAndRemoveUntil(
          //   //   context,
          //   //   BottomBar.routeName,
          //   //   (route) => false,
          //   // );
          // },
          );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static void signOut(BuildContext context) async {
    try {
      await CacheHelper.clearString(key: 'token');
      print('clearedToken');
      navPushReplacement(context, MyLogin());
    } catch (e) {
      print(e.toString());
    }
  }

  // get user data
  // void getUserData(
  //   BuildContext context,
  // ) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('x-auth-token');

  //     if (token == null) {
  //       prefs.setString('x-auth-token', '');
  //     }

  //     var tokenRes = await http.post(
  //       Uri.parse('$uri/tokenIsValid'),
  //       // headers: <String, String>{
  //       //   'Content-Type': 'application/json; charset=UTF-8',
  //       //   'x-auth-token': token!
  //       // },
  //     );

  //     var response = jsonDecode(tokenRes.body);

  //     if (response == true) {
  //       http.Response userRes = await http.get(
  //         Uri.parse('$uri/'),
  //         // headers: <String, String>{
  //         //   'Content-Type': 'application/json; charset=UTF-8',
  //         //   'x-auth-token': token
  //         // },
  //       );

  //       // var userProvider = Provider.of<UserProvider>(context, listen: false);
  //       // userProvider.setUser(userRes.body);
  //     }
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }
}
