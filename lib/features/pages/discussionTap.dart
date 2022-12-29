import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../models/current_user.dart';
import '../../models/post.dart';
import '../../utils/api-paths.dart';
import '../../utils/rest-api-service.dart';
import '../../widgets/post_container.dart';

class DiscussionTap extends StatefulWidget {
  DiscussionTap({super.key});

  @override
  State<DiscussionTap> createState() => _DiscussionTapState();
}

class _DiscussionTapState extends State<DiscussionTap> {
  List<Post> post = [];

  Post? posts;

  _getData() async {
    try {
      var res = await RestApiService.get(ApiPaths.getPosts);
      // print(res.body);
      (jsonDecode(res.body) as List).forEach((json) {
        // print('Json Author');
        // print(json['author']['_id']);
        // print('Current UIser');

        if (CurrentUser.userId.toString() == json['author']['_id'].toString() &&
            json['images'].isEmpty) {
          post.add(Post.fromJson(json));
        }
      });

      return post;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) => ListView.builder(
        itemCount: post.length,
        itemBuilder: (context, int index) {
          if (snapshot.hasData) {
            if (post[index].author.id == CurrentUser.userId &&
                post[index].images!.isEmpty) {
              return DiscussionPosts(post: post[index]);
            } else {
              const SizedBox.shrink();
            }
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
