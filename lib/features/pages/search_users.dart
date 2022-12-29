import 'dart:convert';

import 'package:anime_app/features/auth/screens/other%20users/users_profile_screen.dart';
import 'package:anime_app/providers/user_bloc.dart';
import 'package:anime_app/theme/theme.dart';
import 'package:anime_app/widgets/avatar.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../utils/api-paths.dart';
import '../../utils/rest-api-service.dart';
import '../../widgets/navigate.dart';
import '../auth/screens/other users/network.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  List<User> users = [];
  List<User> addUsers = [];

  _getUsers() async {
    try {
      // http.Response res = await http.get(url, headers: map);
      // print('object');
      var res = await RestApiService.get(ApiPaths.getUsers);
      // print(res.body);
      // print((jsonDecode(res.body) as List));
      // print(res.body);
      users = (jsonDecode(res.body) as List)
          .map((json) => User.fromJson(json))
          .toList();
      // print('wesel?');
      // print(res.body);

      return users;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8.0, 0),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            )
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    users = users.where((user) {
                      var userTitle = user.username;
                      return userTitle.contains(text);
                    }).toList();
                  });
                },
                autofocus: true,
                controller: _searchController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: 'Search',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 10),
            child: Container(
              color: Colors.grey,
              height: 0.3,
              width: double.infinity,
            ),
          ),
        ),
        body: FutureBuilder(
          future: _getUsers(),
          builder: (context, snapshot) => ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, int index) {
              if (snapshot.hasData) {
                return _listItem(index);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // else {
              //   return const Padding(
              //     padding: EdgeInsets.only(top: 20),
              //     child: Center(child: CircularProgressIndicator()),
              //   );
              // }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  _listItem(index) {
    return InkWell(
      onTap: () => navPush(
          context,
          ViewUserProfile(
            user: users[index],
          )),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
        child: Row(
          children: [
            const CircleAvatar(
                backgroundImage: NetworkImage('users[index].profileImage')),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Text(
              users[index].username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
