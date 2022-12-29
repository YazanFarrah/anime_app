import 'package:anime_app/features/auth/screens/nav-screen.dart';
import 'package:anime_app/features/pages/messages.dart';
import 'package:anime_app/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          'Chats',
          style:
              GoogleFonts.lobster(fontSize: 35, color: const Color(0xff2E99C7)),
        ),
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => navPush(context, const NavScreen()),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                print('TODO Search');
              },
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: MessagesPage(),
      ),
    );
  }
}
