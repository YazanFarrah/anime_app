import 'package:anime_app/features/pages/edit-profile.dart';
import 'package:anime_app/network/remote/auth-repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/pallete.dart';
import '../../../widgets/icon-buttons.dart';
import '../../../widgets/widgets.dart';
import '../../pages/pages.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Center(
              child: Text(
                'Username',
                style: GoogleFonts.lobster(
                    fontSize: 20, color: const Color(0xff2E99C7)),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: IconBackground(
                icon: Icons.more,
                onTap: () {
                  print('TODO Settings');
                },
              ),
            ),
          ],
        ),
        body: Column(
          // padding: EdgeInsets.zero,
          children: [
            buildTop(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: const [
                        Text(
                          '4',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'Posts',
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const VerticalDivider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: const [
                        Text(
                          '1.2m',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'Followers',
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const VerticalDivider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: const [
                        Text(
                          '23',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'Following',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            buildContent(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Color(0xFF2E99C7),
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.grid_3x3,
                    color: Pallete.greyColor,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person_2_outlined,
                    color: Pallete.greyColor,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Pallete.greyColor,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: Pallete.greyColor,
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  PostsTap(),
                  DiscussionTap(),
                  FavTap(),
                  SavedTap(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContent() => Container(
        padding: const EdgeInsets.only(left: 15),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Yazan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'data',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        elevation: 8,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        backgroundColor: Colors.white,
                        // side: BorderSide(
                        //   width: 1,
                        //   color: Colors.grey,
                        // ),
                      ),
                      onPressed: () => navPush(context, EditProfile()),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => AuthRepository.signOut(context),
                    icon: const Icon(Icons.link),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          // margin: EdgeInsets.only(bottom: 200),
          child: buildCoverImage(),
        ),
        Positioned(
          top: 70,
          left: 15,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
            'https://images.unsplash.com/photo-1578632749014-ca77efd052eb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGFuaW1lfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
            width: double.infinity,
            height: 100,
            fit: BoxFit.cover),
      );

  Widget buildProfileImage() => Row(
        children: const [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(
                'https://t3.ftcdn.net/jpg/01/67/26/42/240_F_167264239_MJTYeDoQEItDJqlhVV13VVdQ94ViScwe.jpg'),
          ),

          //I used IntrinsicHeight to use vertical divider
        ],
      );
}
