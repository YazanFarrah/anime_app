import 'package:anime_app/features/pages/comments.dart';
import 'package:anime_app/models/current_user.dart';
import 'package:anime_app/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../models/error-handling.dart';
import '../../models/post.dart';
import 'package:http/http.dart' as http;

import '../../network/remote/auth-repository.dart';
import '../motion_toast.dart';

class InteractButton extends StatelessWidget {
  final Post? post;
  final double size;
  final IconData isLikedIcon;
  final IconData isNotLikedIcon;
  final Color initialAnimateColor;
  final Color endAnimateColor;
  final Color isLikedColor;
  final Color isNotLikedColor;
  final int interactiCount;

  const InteractButton({
    super.key,
    required this.size,
    required this.isLikedIcon,
    required this.isNotLikedIcon,
    required this.isLikedColor,
    required this.isNotLikedColor,
    required this.initialAnimateColor,
    required this.endAnimateColor,
    required this.interactiCount,
    required this.post,
  });

  Future<bool> onLike(bool isLiked) async {
    return isLiked;
  }

  void addLikes(BuildContext context) async {
    try {
      String id = post!.id.trim();
      final headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthRepository.token}',
      };
      final url = Uri.parse(
          'https://animebe-production.up.railway.app/api/posts/$id/like');

      var res = await http.patch(url, headers: headers);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            displayDeleteMotionToast(
                context: context,
                description: 'Like has been added successfully',
                msg: 'Like');
            // Navigator.pop(context);
          });
    } catch (e) {
      print(e.toString());
    }
  }

//  void removeLikes(BuildContext context) async {
//     try {
//       String id = post.id.trim();
//       final headers = {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${AuthRepository.token}',
//       };
  // final url = Uri.parse(
  //     'https://animebe-production.up.railway.app/api/posts/$id/like');
//       //remove like

//       var res = await http.patch(url, headers: headers);

//       httpErrorHandle(
//           response: res,
//           context: context,
//           onSuccess: () {
//             displayDeleteMotionToast(
//                 context: context,
//                 description: 'Like has been added successfully',
//                 msg: 'Like');
//             // Navigator.pop(context);
//           });
//     } catch (e) {
//       print(e.toString());
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: size,
      circleColor:
          CircleColor(start: initialAnimateColor, end: endAnimateColor),
      bubblesColor: BubblesColor(
        dotPrimaryColor: initialAnimateColor,
        dotSecondaryColor: endAnimateColor,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? isLikedIcon : isNotLikedIcon,
          color: isLiked ? isLikedColor : isNotLikedColor,
          size: 25,
        );
      },
      // onTap: (isLiked) async {
      //   isLiked ? null : addLikes(context);
      // },
      // onTap: (isLiked) async {
      //   isLiked ?  : addLikes(context);
      // },
      likeCount: interactiCount,
      countPostion: CountPostion.right,
      bubblesSize: MediaQuery.of(context).size.height * 0.07,
    );
  }
}
