import 'dart:convert';

import 'package:anime_app/features/auth/screens/chat_screen.dart';
import 'package:anime_app/models/current_user.dart';
import 'package:anime_app/models/post.dart';
import 'package:anime_app/network/remote/api_services.dart';
import 'package:anime_app/theme/theme.dart';
import 'package:anime_app/utils/api-paths.dart';
import 'package:anime_app/utils/rest-api-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../models/models.dart';
import '../../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> post = [];

  // ScrollController? controller;

  _getData() async {
    try {
      var res = await RestApiService.get(ApiPaths.getPosts);
      ;
      post = (jsonDecode(res.body) as List)
          .map((json) => Post.fromJson(json))
          .toList();

      return post;
    } catch (e) {
      print(e.toString());
    }
  }
  // @override
  // void initState() {
  //   super.initState();
  //   controller = ScrollController()..addListener(() );
  // }

  //  void _scrollListener() {
  //   print(controller!.position.extentAfter);
  //   if (controller!.position.extentAfter < 500) {
  //     setState(() {
  //       post.addAll(List.generate(42, (index) => 'Inserted $index'));
  //     });
  //   }
  // }
  // _getUserData() async {
  Future refresh() async {
    setState(() {
      _getData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Name',
            style:
                GoogleFonts.lobster(color: AppColors.secondary, fontSize: 35),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                child: SvgPicture.asset('assets/images/chat.svg'),
                onTap: () => navPush(context, const ChatScreen()),
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) => LiquidPullToRefresh(
            height: MediaQuery.of(context).size.height * 0.1,
            backgroundColor: Colors.white,
            showChildOpacityTransition: false,
            animSpeedFactor: 2,
            color: Colors.blueGrey,
            onRefresh: refresh,
            child: ListView.builder(
              // controller: controller,
              itemCount: post.length,
              itemBuilder: (context, int index) {
                if (snapshot.hasData) {
                  return PostContainer(post: post[index]);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
