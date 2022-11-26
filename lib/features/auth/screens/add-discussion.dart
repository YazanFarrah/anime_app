import 'package:anime_app/network/remote/api_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../theme/pallete.dart';
import '../../../widgets/widgets.dart';

class AddDiscussion extends StatefulWidget {
  const AddDiscussion({super.key});

  @override
  State<AddDiscussion> createState() => _AddDiscussionState();
}

class _AddDiscussionState extends State<AddDiscussion> {
  final TextEditingController _discussionController = TextEditingController();
  final _addDiscussionFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _discussionController.dispose();
    super.dispose();
  }

  void postDiscussion() {
    if (_addDiscussionFormKey.currentState!.validate() &&
        _discussionController.text.isNotEmpty) {
      ApiServices.addDiscussion(
        token:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzdlNjlkM2E5NzRjZWFmZjU2NTA2ZGUiLCJ1cGRhdGVEYXRlIjoiMTEvMjMvMjAyMiwgNTo1NjoxNSBQTSIsImNyZWF0ZURhdGUiOiIxMS8yMy8yMDIyLCA1OjU2OjE1IFBNIiwiZW1haWwiOiJtYW55YWtAZ21haWwuY29tIiwidXNlcm5hbWUiOiJtYW55YWsiLCJiaXJ0aGRheSI6IjEyLTI4LTIwMjIiLCJwb3N0cyI6W10sImNvbW1lbnRzIjpbXSwiZm9sbG93ZXJzIjpbXSwiZm9sbG93aW5nIjpbXSwiYmxvY2tlZFVzZXJzIjpbXSwicm9sZSI6IjEiLCJfX3YiOjAsImlhdCI6MTY2OTQxMzU1OSwiZXhwIjoxNjcwMDE4MzU5fQ.uhxJJ197tqhz8yGRCl3vj9UdbEyd0_41df-uidMynPA',
        context: context,
        // name: ,
        description: _discussionController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
              onPressed: postDiscussion,
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Color(0xff2E99C7),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
        centerTitle: true,
        title: const Text(
          'Add a post',
          style: TextStyle(
            color: Color(0xff2E99C7),
            fontSize: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _addDiscussionFormKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://t3.ftcdn.net/jpg/01/67/26/42/240_F_167264239_MJTYeDoQEItDJqlhVV13VVdQ94ViScwe.jpg'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        showToast();
                      } else {
                        return null;
                      }
                    },
                    controller: _discussionController,
                    decoration: const InputDecoration(
                        hintText: 'Write a caption!', border: InputBorder.none),
                    maxLines: 8,
                  ),
                ),
                const SizedBox(
                  height: 45,
                  width: 45,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future showToast() async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: "Can't post an empty discussion!",
        fontSize: 18,
        backgroundColor: Pallete.redColor,
        gravity: ToastGravity.CENTER);
  }
}
