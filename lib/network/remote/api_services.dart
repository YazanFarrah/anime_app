import 'dart:convert';
import 'dart:io';

import 'package:anime_app/models/current_user.dart';
import 'package:anime_app/models/post.dart';
import 'package:anime_app/network/local/shared_preferences.dart';
import 'package:anime_app/network/remote/auth-repository.dart';
import 'package:anime_app/widgets/motion_toast.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
    // required String category,
    required List<File> image,
    // required List<File> video,
    // Uint8List? _file = null,
  }) async {
    // try {
    final cloudinary = CloudinaryPublic('doxx7939c', 'fbmy2ykr');
    List<String> imageUrls = [];
    // List<String> videoUrls = [];

    for (int i = 0; i < image.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image[i].path, folder: 'name'),
      );
      imageUrls.add(res.secureUrl);
    }

    // for (int i = 0; i < video.length; i++) {
    //   CloudinaryResponse res = await cloudinary.uploadFile(
    //     CloudinaryFile.fromFile(video[i].path, folder: 'videos'),
    //   );
    //   videoUrls.add(res.secureUrl);
    // }
    print('entered');
    // final url = Uri.parse(ApiPaths.postPosts);
    Map data = {
      'text': description,
      'images': imageUrls,
      // 'videos': [
      //   'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
      // ],
    };
    print(data);
    var res = await RestApiService.post(
      ApiPaths.createPosts,
      // "/api/posts",
      data,
    );
    print('response= ${data['text']}');

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

    print(
        'Ay eshe nshufu: ${data.runtimeType} \n ${description.runtimeType}\n ${imageUrls.runtimeType}');
  }

  static void changeProfilePic({
    required BuildContext context,
    required String description,
    // required String category,
    required List<File> image,
    // required List<File> video,
    // Uint8List? _file = null,
  }) async {
    // try {
    final cloudinary = CloudinaryPublic('doxx7939c', 'fbmy2ykr');
    List<String> imageUrls = [];
    // List<String> videoUrls = [];

    for (int i = 0; i < image.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image[i].path, folder: 'profileImages'),
      );
      imageUrls.add(res.secureUrl);
    }

    // for (int i = 0; i < video.length; i++) {
    //   CloudinaryResponse res = await cloudinary.uploadFile(
    //     CloudinaryFile.fromFile(video[i].path, folder: 'videos'),
    //   );
    //   videoUrls.add(res.secureUrl);
    // }

    // final url = Uri.parse(ApiPaths.postPosts);
    Map data = {
      'text': description,
      'images': imageUrls,
      // 'videos': [
      //   'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
      // ],
    };
    print(data);
    var res = await RestApiService.post(
      ApiPaths.createPosts,
      // "/api/posts",
      data,
    );
    print('response= ${data['text']}');

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

    print(
        'Ay eshe nshufu: ${data.runtimeType} \n ${description.runtimeType}\n ${imageUrls.runtimeType}');
  }

  static void addLikes({
    required BuildContext context,
    required String id,
  }) async {
    try {
      final url = Uri.parse(
          'https://animebe-production.up.railway.app/api/posts/$id/like');

      var res = await http.patch(url, headers: RestApiService.apiHeaders);
      // print(jsonDecode(res.body));
      // print(res.body);
      // print(res.statusCode);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(
            'post liked',
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static void patchAnimefan({
    required BuildContext context,
    String? email,
    String? username,
  }) async {
    var data = {
      'username': 'username',
      'email': 'email@gmail.com',
    };

    String userId = CurrentUser.userId;

    try {
      final url = Uri.parse(
          'https://animebe-production.up.railway.app/api/anime-fan/$userId');

      final apiHeaders = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthRepository.token}',
      };
      var res = await http.patch(url, headers: apiHeaders, body: data);
      print(res.body);
      print(res.request);
      print(res.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

  static void getCurrentUser({
    required BuildContext context,
  }) async {
    String userId = CurrentUser.userId;
    try {
      final url = Uri.parse(
          //correct link?
          'https://animebe-production.up.railway.app/api/user/$userId');
      var res = await http.get(url, headers: RestApiService.apiHeaders);
      // var followedUsers = json.decode(res.body)['following'];

      // print(json.decode(followedUsers));

      // (jsonDecode(res.body) as List).forEach((json) {
      //   followedUsers.add(json);
      // });
      print((res.body));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(
            'get user info succeed  ',
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static void followUnfollow({
    required BuildContext context,
    required String userId,
  }) async {
    try {
      final url = Uri.parse(
          'https://animebe-production.up.railway.app/api/anime-fan/$userId');

      var res = await http.patch(url, headers: RestApiService.apiHeaders);
      // print(jsonDecode(res.body));
      // print(res.body);
      // print(res.statusCode);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(
            'user followed/unfollowed ',
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<Post>> getData({required List<Post> post}) async {
    Map<String, String> map = RestApiService.apiHeaders;
    final url = Uri.parse('http://${ApiPaths.baseUrl}${ApiPaths.getPosts}');
    http.Response res = await http.get(url, headers: map);
    if (res.statusCode == 200 || res.statusCode == 201) {
      print('s');
      post = (jsonDecode(res.body) as List)
          .map((json) => Post.fromJson(json))
          .toList();

      return post;
    } else {
      print('object');
      print(res.body);
    }
    return post;
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

  patchImage(dynamic data, dynamic id) async {
    // here try to get the users data to change when this function is used
    String token = await CacheHelper.getString(key: 'token');
    RestApiService.put('${ApiPaths.baseUrl}${ApiPaths.getUsers}/$id', data);
  }

  static deletePost({
    required String id,
    required BuildContext context,
  }) async {
    var data = {'_id': id};
    // final deleteUrl =
    //     Uri.parse('https://${ApiPaths.baseUrl}${ApiPaths.deletePosts}/$id');
    try {
      print('entered');
      var res =
          await RestApiService.delete('${ApiPaths.deletePosts}/$id', data);
      print(res.body);
      print(res.statusCode);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          displayDeleteMotionToast(
              context: context,
              description: 'Post has been deleted successfully',
              msg: 'Deleted');
          // Navigator.pop(context);
        },
      );

      // print(deleteUrl);
      // http.Response res = await http.delete(deleteUrl);
      // if (res.statusCode == 200 || res.statusCode == 201) {
      //   print('in');
      // } else {
      //   print(res.statusCode);
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  static editPost({
    required String id,
    required Map data,
    required BuildContext context,
  }) async {
    // final EditUrl =
    // Uri.parse('https://${ApiPaths.baseUrl}${ApiPaths.editPosts}/$id');
    try {
      var res = await RestApiService.put('${ApiPaths.editPosts}/$id', data);
      // print(EditUrl);
      // http.Response res = await http.put(EditUrl, body: data);
      print(res.body);
      print(res.statusCode);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          displayDeleteMotionToast(
              context: context,
              description: 'Post has been Edited successfully',
              msg: 'Edit');
          // Navigator.pop(context);
        },
      );
      // RestApiService.delete(
      //     'https://' + ApiPaths.baseUrl + ApiPaths.deletePosts + '/$id');
    } catch (e) {
      print(e.toString());
    }
  }

  static void addComment({
    required BuildContext context,
    required String text,
    required String postId,
    required String authorId,

    // required String postAuthor,
  }) async {
    try {
      var data = {
        'text': text,
        'replayTo': authorId,
      };
      var res = await RestApiService.post(
        '${ApiPaths.createPosts}/${postId.trim()}/comments',
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
          // Navigator.pop(context);
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static void getComments(String postId, BuildContext context) async {
    try {
      print('entered get comment');

      var res = await RestApiService.get(
        '${ApiPaths.createPosts}/${postId.trim()}/comments',
        // "/api/posts",
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
          // Navigator.pop(context);
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
