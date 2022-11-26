// import 'dart:io';

// import 'package:anime_app/core/constants/utils.dart';
// import 'package:anime_app/models/post.dart';
// import 'package:anime_app/utils/api-paths.dart';
// import 'package:anime_app/utils/rest-api-service.dart';
// import 'package:cloudinary_public/cloudinary_public.dart';
// import 'package:flutter/material.dart';

// import '../models/models.dart';

// class AdminServices {
//   void postPost({
//     required BuildContext context,
//     // required String name,
//     required String description,
//     required String category,
//     required List<File> media,
//   }) async {
//     try {
//       final cloudinary = CloudinaryPublic('doxx7939c', 'fbmy2ykr');
//       List<String> mediaUrls = [];

//       for (int i = 0; i < media.length; i++) {
//         CloudinaryResponse res = await cloudinary.uploadFile(
//           CloudinaryFile.fromFile(media[i].path, folder: 'name'),
//         );
//         mediaUrls.add(res.secureUrl);
//       }

//       var data = Post(
//         // name: name,
//         description: description,
//         files: mediaUrls,
//         // category: category,
//       );
//       var res = await RestApiService.post(
//         ApiPaths.createPosts,
//         // "/api/posts",
//         data,
//       );

//       httpErrorHandle(
//           context: context,
//           response: res,
//           onSuccess: () {
//             showSnackBar(context, 'Posted successfully!');
//             Navigator.pop(context);
//           });
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
// }
