import 'dart:convert';

import 'package:anime_app/models/current_user.dart';
import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../utils/api-paths.dart';
import '../../utils/rest-api-service.dart';
import '../../widgets/post_container.dart';

class UsersPostsTap extends StatelessWidget {
  UsersPostsTap({super.key});

  List<Post> post = [];

  // Post? posts;
  _getData() async {
    try {
      var res = await RestApiService.get(ApiPaths.getPosts);

      // post = (jsonDecode(res.body) as List).map((json) {
      //   if (json['author']['_id'] == CurrentUser.userId) {
      //     return Post.fromJson(json);
      //   }
      // }).toList();
      // print(res.body);
      (jsonDecode(res.body) as List).forEach((json) {
        // print('Json Author');
        // print(json['author']['_id']);
        // print('Current UIser');

        if (CurrentUser.userId.toString() == json['author']['_id'].toString() &&
            json['images'].isNotEmpty) {
          // print(json['images']);
          post.add(Post.fromJson(json));
        }
      });

      print(post.length);

      return post;
    } catch (e) {
      print(e.toString());
    }
  }

  // Future refresh() async {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) => GridView.builder(
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: post.length,
        itemBuilder: (context, int index) {
          if (snapshot.hasData) {
            return Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => ViewPost(post: post[index]),
                      )),
                  child: Container(
                      child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(post[index].images![0]),
                  )
                      // PostImage(post: post[index]),
                      ),
                ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox.shrink();

          // return const CircularProgressIndicator();
        },
      ),
    );
  }
}
