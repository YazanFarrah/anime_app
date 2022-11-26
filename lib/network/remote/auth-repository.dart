import 'package:anime_app/utils/api-paths.dart';
import 'package:anime_app/utils/rest-api-service.dart';
import 'package:anime_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../core/constants/constants.dart';
import '../../core/constants/utils.dart';
import 'package:anime_app/models/models.dart';

import '../../features/auth/screens/screens.dart';
import '../local/shared_preferences.dart';

class AuthRepository {
  static String? token;
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
      print('object');
      // User user = User(
      //   id: '',
      //   name: 'name',
      //   password: password,
      //   email: email,

      //   token: '',
      //   // cart: [],
      // );

      final data = {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'username': username,
        'birthday': birthday,
      };
      print('a');
      var res = await RestApiService.post(
        ApiPaths.signUp,
        data,
      );

      print(res);
      print('b');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
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
      final data = {
        'email': email,
        'password': password,
      };
      print('i');
      var res = await RestApiService.post(
        ApiPaths.logIn,
        data,
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            CacheHelper.setString(
                key: 'token', value: jsonDecode(res.body)['token']);
            // print(jsonDecode(res.body)['token']);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const NavScreen()));
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
      navPushReplacement(context, MyLogin());
    } catch (e) {
      print(e.toString());
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        // headers: <String, String>{
        //   'Content-Type': 'application/json; charset=UTF-8',
        //   'x-auth-token': token!
        // },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          // headers: <String, String>{
          //   'Content-Type': 'application/json; charset=UTF-8',
          //   'x-auth-token': token
          // },
        );

        // var userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
