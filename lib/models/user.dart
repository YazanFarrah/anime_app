import 'dart:convert';

class User {
  final String? id;
  final String name;
  final String username;
  final String email;
  final String password;
  final String token;

  User({
    required this.username,
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['_id'].toString(),
      username: map['username'].toString(),
      name: map['name'].toString(),
      email: map['email'].toString(),
      password: map['password'].toString(),
      token: map['token'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  // factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
