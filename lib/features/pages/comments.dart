import 'package:anime_app/network/remote/api_services.dart';
import 'package:anime_app/theme/theme.dart';
import 'package:anime_app/utils/rest-api-service.dart';
import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../widgets/profile_avatar.dart';
import 'package:http/http.dart' as http;

class CommentsPage extends StatefulWidget {
  const CommentsPage({
    super.key,
  });

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

Map<String, String> map = RestApiService.apiHeaders;
TextEditingController _commentTextController = TextEditingController();

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as Post;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
          style: TextStyle(color: AppColors.textDark),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.textDark,
          ),
          onPressed: () {
            _commentTextController.clear();
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ProfileAvatar(imageUrl: post.author.profileImage!, radius: 20),
                const SizedBox(
                  width: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      post.author.username,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(post.date),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.12, 0, 0, 0),
              child: Text(post.text),
            ),
            Divider(
              // indent: 10,
              // endIndent: 10,
              thickness: 0.8,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            FutureBuilder(
              builder: (context, snapshot) => Expanded(
                child: ListView.builder(
                  itemCount: post.comments.length,
                  itemBuilder: (context, int index) {
                    if (snapshot.hasData) {
                      return Container(
                        color: Colors.red,
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            Text(
                              post.comments[index].toString(),
                            )
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (post.comments.isEmpty) {
                      return const Center(child: Text('ssss'));
                    }
                    return const Center(
                        child: Text('Be the first to comment!'));
                  },
                ),
              ),
            ),
            _CommentsBar(post: post)
          ],
        ),
      ),
    ));
  }
}

class _CommentsBar extends StatefulWidget {
  final Post post;
  const _CommentsBar({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<_CommentsBar> createState() => _CommentsBarState();
}

final GlobalKey<FormState> _formKey = GlobalKey();

class _CommentsBarState extends State<_CommentsBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Row(
          children: [
            const CircleAvatar(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: _commentTextController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                    hintText: 'Type a comment...',
                    border: InputBorder.none,
                    suffix: TextButton(
                      onPressed: () {
                        if (_commentTextController.text.trim().isNotEmpty) {
                          ApiServices.addComment(
                              context: context,
                              text: 'comment test',
                              postId: widget.post.id,
                              authorId: widget.post.author.id);
                        }
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _commentTextController.text.isEmpty
                                ? AppColors.textDark
                                : AppColors.secondary),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
