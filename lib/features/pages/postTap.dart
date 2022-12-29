import 'dart:convert';

import 'package:anime_app/models/current_user.dart';
import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../utils/api-paths.dart';
import '../../utils/rest-api-service.dart';
import '../../widgets/post_container.dart';

class PostsTap extends StatefulWidget {
  PostsTap({super.key});

  @override
  State<PostsTap> createState() => _PostsTapState();
}

class _PostsTapState extends State<PostsTap> {
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
            // print(post[index]!.images.length);
            // return Container(
            //   child:
            //       Image(image: NetworkImage(post[index].images.toString())),
            // );
            // int length;
            // for (int i= 0; i < length; i

            return Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => ViewPost(post: post[index]),
                      )),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(post[index].images![0]),
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
