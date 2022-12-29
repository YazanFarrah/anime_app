import 'package:anime_app/core/utils.dart';
import 'package:anime_app/models/models.dart';
import 'package:anime_app/network/remote/auth-repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class CurrentUser {
  static dynamic userToken = JwtDecoder.decode(AuthRepository.token!);
  static dynamic username = userToken['username'].toString().capitalize();
  static dynamic email = userToken['email'].toString();
  static List<dynamic> followers = userToken['followers'];
  static List<dynamic> following = userToken['following'];
  static List<dynamic> posts = userToken['posts'];
  static List<dynamic> likes = userToken['likedPosts'];
  // .map((json) => CurrentUserPosts.fromJson(json))
  // .toList();
  // CurrentUserPosts.fromJson(userToken['posts']);
  // static List<dynamic> deletedPosts = userToken['isDeleted'];
  static dynamic profileImage = userToken['profilePicture'];
  static dynamic coverImage = userToken['coverPicture'];
  static String userId = userToken['_id'];
}

class CurrentUserPosts {
  final String id;
  final User author;
  String text;

  CurrentUserPosts({
    required this.id,
    required this.author,
    required this.text,
  });

  factory CurrentUserPosts.fromJson(Map<String, dynamic> map) {
    return CurrentUserPosts(
      // currentUser: map['posts'],
      id: map['_id'],
      author: User.fromJson(map['author']),

      text: map['text'],
      // author: map['author'],
    );
  }
}
