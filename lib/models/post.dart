// import 'dart:convert';

// class Post {
//   // final String name;
//   final String description;
//   final List<String> files;
//   // final String category;
//   String? id;
//   String? userId;

//   Post({
//     // required this.name,
//     required this.description,
//     required this.files,
//     // required this.category,
//     this.id,
//     this.userId,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       // 'name': name,
//       'id': id,
//       'text': description,
//       'images': files,
//       // 'category': category,
//       'userId': userId,
//     };
//   }

//   factory Post.fromMap(Map<String, dynamic> map) {
//     return Post(
//       // name: map['name'] ?? '',
//       description: map['text'] ?? '',
//       files: List<String>.from(map['images']),
//       // category: map['category'] ?? '',
//       //we're not passing the id because mongo creates it for us
//       // id: map['_id'],
//       // userId: map['userId'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
// }
