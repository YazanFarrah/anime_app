// import 'dart:convert';

// import 'dart:ffi';

import 'package:anime_app/models/current_user.dart';
import 'package:anime_app/models/user.dart';

class Post {
  // final User? user;
  final String id;
  final User author;
  final CurrentUser? currentUser;
  String text;
  final List<dynamic>? images;
  final List<dynamic>? videos;
  final List<dynamic>? likes;
  final List<dynamic> comments;
  final String date;

  Post({
    required this.id,
    this.currentUser,
    required this.author,
    required this.date,
    required this.likes,
    required this.comments,
    required this.images,
    this.videos,
    required this.text,
  });

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      // currentUser: map['posts'],
      id: map['_id'],
      date: map['createDate'],
      likes: map['likes'],
      comments: map['comments'],
      // user: map[''],
      author: User.fromJson(map['author']),
      // author: map[''],
      images: map['images'] ?? [],
      videos: map['videos'],
      text: map['text'],
      // author: map['author'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
