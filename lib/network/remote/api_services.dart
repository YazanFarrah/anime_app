import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../utils/api-paths.dart';
import '../../utils/rest-api-service.dart';
import '../../utils/utils.dart';

class ApiServices {
  static void addDiscussion({
    required BuildContext context,
    required String description,
    required String token,
  }) async {
    try {
      final data = {
        'text': description,
        'token': token,
      };
      var res = await RestApiService.post(
        ApiPaths.createPosts,
        data,
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            'Has been posted',
            context,
          );
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  static void createPost({
    required BuildContext context,
    required String description,
    required String category,
    required List<File> image,
    required List<File> video,
    // Uint8List? _file = null,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('doxx7939c', 'fbmy2ykr');
      List<String> imageUrls = [];
      List<String> videoUrls = [];

      for (int i = 0; i < image.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image[i].path, folder: 'name'),
        );
        imageUrls.add(res.secureUrl);
      }

      for (int i = 0; i < video.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(video[i].path, folder: 'videos'),
        );
        videoUrls.add(res.secureUrl);
      }
      print('entered');
      // final url = Uri.parse(ApiPaths.postPosts);
      var data = {
        'text': description,
        'images': imageUrls,
        'videos': videoUrls,
      };
      print(data);
      var res = await RestApiService.post(
        ApiPaths.createPosts,
        // "/api/posts",
        data,
      );
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            'Has been posted',
            context,
          );
          Navigator.pop(context);
        },
      );
      print('object');
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
      print(e.toString());
    }
  }

  static void addVideo({
    required BuildContext context,
    required String description,
    required String category,
    required List<File> video,
    // Uint8List? _file = null,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('doxx7939c', 'fbmy2ykr');
      List<String> videoUrls = [];

      for (int i = 0; i < video.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(video[i].path, folder: 'videos'),
        );
        videoUrls.add(res.secureUrl);
      }

      print('entered');
      // final url = Uri.parse(ApiPaths.postPosts);
      var data = {
        'text': description,
        'videos': videoUrls,
        // 'videos': [''],
      };
      print(data);
      var res = await RestApiService.post(
        ApiPaths.createPosts,
        // "/api/posts",
        data,
      );
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            'Has been posted',
            context,
          );
          Navigator.pop(context);
        },
      );
      print('object');
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
      print(e.toString());
    }
  }
}
