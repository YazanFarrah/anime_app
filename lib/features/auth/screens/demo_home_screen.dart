import 'package:anime_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenDemo extends StatelessWidget {
  const HomeScreenDemo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
        child:
            // Stream<List<Post>> getPostsByUser(uid),
            Text('data'));
  }
}
