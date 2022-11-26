import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../core/constants/utils.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  print('in??');
  switch (response.statusCode) {
    case 200:
      print('200');
      onSuccess();
      print('success');
      break;
    case 201:
      print('201');
      onSuccess();
      break;
    case 400:
      print('400');
      // print(response.body);
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      print('500');
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      print(response.statusCode);
    // showSnackBar(context, response.toString());
  }
}
