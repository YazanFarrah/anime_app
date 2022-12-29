import 'package:anime_app/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<User> parseUser(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var users = list.map((model) => User.fromJson(model)).toList();
  return users;
}

Future<List<User>> fetchUsers() async {
  final url =
      Uri.parse('https://animebe-production.up.railway.app/api/anime-fan');
  var res = await http.get(url);
  if (res.statusCode == 200 || res.statusCode == 201) {
    return compute(parseUser, res.body);
  } else {
    throw Exception('Request Api Error');
  }
}
