import 'package:anime_app/network/remote/auth-repository.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String token;
  final String? profileImage;
  final List<dynamic> likedPosts;
  final List<dynamic> followers;
  final List<dynamic> followings;

  User({
    required this.followers,
    required this.followings,
    required this.likedPosts,
    this.profileImage,
    required this.username,
    required this.id,
    required this.email,
    required this.password,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      followers: map['followers'],
      followings: map['following'],
      profileImage: map['profilePicture'] ??
          'https://i.pinimg.com/236x/81/70/21/81702128c4248529f9dc6e7506432004.jpg',
      id: map['_id'].toString(),
      username: map['username'],
      email: map['email'].toString(),
      password: map['password'].toString(),
      token: AuthRepository.token!,
      likedPosts: map['likedPosts'],
      // likedPosts: List<Map<String, dynamic>>.from(
      //   map['likedPosts']?.map(
      //     (x) => Map<String, dynamic>.from(x),
      //   ),
      // ),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
