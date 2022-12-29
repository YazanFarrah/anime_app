import 'package:anime_app/models/post.dart';
import 'package:anime_app/network/remote/api_services.dart';
import 'package:anime_app/theme/theme.dart';
import 'package:anime_app/widgets/dialogs/focused_menu.dart';
import 'package:anime_app/widgets/post_container.dart';
import 'package:anime_app/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class PostInfo extends StatelessWidget {
  final Post post;
  final Widget widget;
  final String title1;
  final Color title1Color;
  final String title2;
  final Color title2Color;
  final Function fnc1;
  final Function fnc2;
  final IconData icon1;
  final Color icon1Color;
  final IconData icon2;
  final Color icon2Color;
  final Color backgroundColor1;
  final Color backgroundColor2;
  const PostInfo({
    super.key,
    required this.post,
    required this.widget,
    required this.title1,
    required this.title1Color,
    required this.title2,
    required this.title2Color,
    required this.fnc1,
    required this.fnc2,
    required this.icon1,
    required this.icon1Color,
    required this.icon2,
    required this.icon2Color,
    required this.backgroundColor1,
    required this.backgroundColor2,
  });

  @override
  Widget build(BuildContext context) {
    // int index;
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.author.profileImage!, radius: 24),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Row(
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
        ),
        FocusedMenu(
          widget: const Icon(Icons.more_horiz),
          backgroundColor1: backgroundColor1,
          backgroundColor2: backgroundColor2,
          fnc1: fnc1,
          fnc2: fnc2,
          title1: title1,
          title1Color: title1Color,
          title2: title2,
          title2Color: title2Color,
          icon1: icon1,
          icon1Color: icon1Color,
          icon2: icon2,
          icon2Color: icon2Color,
        ),
      ],
    );
  }
}
