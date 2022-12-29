import 'dart:convert';

import 'package:anime_app/features/pages/edit_profile.dart';
import 'package:anime_app/l10n/ln10.dart';
import 'package:anime_app/models/current_user.dart';
import 'package:anime_app/network/remote/api_services.dart';
import 'package:anime_app/network/remote/auth-repository.dart';
import 'package:anime_app/providers/language.dart';
import 'package:anime_app/theme/theme.dart';
import 'package:anime_app/utils/api-paths.dart';
import 'package:anime_app/utils/rest-api-service.dart';
import 'package:anime_app/widgets/buttons/dialog_button.dart';
import 'package:anime_app/widgets/pop_over.dart';
import 'package:anime_app/widgets/profile_clipper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../models/models.dart';
import '../../../widgets/widgets.dart';
import '../../pages/pages.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  final url = Uri.parse('https://${ApiPaths.baseUrl}${ApiPaths.getUsers}');
  Map<String, String> map = RestApiService.apiHeaders;
  List<User> user = [];

  getData() async {
    http.Response res = await http.get(url, headers: map);
    if (res.statusCode == 200 || res.statusCode == 201) {
      print('s');
      user = (jsonDecode(res.body) as List)
          .map((json) => User.fromJson(json))
          .toList();

      return user;
    } else {
      print('object');
      print(res.body);
    }
  }

  void settingsModalSheet(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context, listen: false);
    final locale = provider.locale ?? Locale('en');
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Popover(
            child: Column(
              children: [
                _buildListItem(
                  context,
                  title: Text(
                    AppLocalizations.of(context)!.darkMode,
                  ),
                  leading: const Icon(Icons.sunny),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                    // dragStartBehavior: DragStartBehavior.start,
                  ),
                ),
                _buildListItem(
                  context,
                  title: Text(
                    AppLocalizations.of(context)!.language,
                  ),
                  leading: const Icon(Icons.language),
                  trailing: DropdownButton(
                      value: locale,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: L10n.all.map(
                        (locale) {
                          final flag = L10n.getFlag(locale.languageCode);
                          return DropdownMenuItem(
                            value: locale,
                            child: Text(flag),
                            onTap: () {
                              final provider = Provider.of<LanguageProvider>(
                                  context,
                                  listen: false);
                              provider.setLocale(locale);
                              // Navigator.pop(context);
                            },
                          );
                        },
                      ).toList(),
                      onChanged: (_) {}
                      //(String? newValue) async {
                      //   SharedPreferences pref =
                      //       await SharedPreferences.getInstance();
                      //   pref.setString('langauge', newValue!);
                      //   _language.setLanguage(newValue);
                      //   _selectedLanguage = newValue;
                      //   setState(
                      //     () {
                      //       _selectedLanguage = newValue!;
                      //     },
                      //   );
                      //   Navigator.pop(context);
                      // },
                      ),
                ),
                InkWell(
                  child: _buildListItem(
                    context,
                    title: Text(AppLocalizations.of(context)!.logOut),
                    leading: DialogBtn(
                      mainIcon: Icons.logout,
                      context: context,
                      message: 'Are you sure you want to log out?',
                      title: 'Log out',
                      text1: 'Yes',
                      text2: 'No',
                      btn1Function: () => AuthRepository.signOut(context),
                      btn2Function: () => Navigator.pop(context),
                      icon1Color: Colors.green,
                      icon2Color: Colors.red,
                      iconText1Color: Colors.green,
                      iconText2Color: Colors.red,
                      icon1: Icons.check,
                      icon2: Icons.cancel,
                      mainIconColor: AppColors.secondary,
                    ),
                    trailing: const CircleAvatar(
                        backgroundImage: NetworkImage(
                      'https://t3.ftcdn.net/jpg/01/67/26/42/240_F_167264239_MJTYeDoQEItDJqlhVV13VVdQ94ViScwe.jpg',
                    )),
                  ),
                ),
                _buildListItem(
                  context,
                  title: Text(
                    AppLocalizations.of(context)!.about,
                  ),
                  leading: const Icon(
                    Icons.info_outline,
                    color: AppColors.iconDark,
                  ),
                  trailing: Text('asdasdnasdasd'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required Widget title,
    required Widget leading,
    required Widget trailing,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          leading,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: DefaultTextStyle(
              style: const TextStyle(color: AppColors.textDark),
              child: title,
            ),
          ),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }

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
          centerTitle: false,
          title: Align(
            alignment: Alignment.topLeft,
            child: Text(
              //username
              CurrentUser.username,
              style: GoogleFonts.lobster(
                fontSize: 30,
                color: const Color(0xff2E99C7),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(FeatherIcons.moreHorizontal),
              onPressed: () {
                settingsModalSheet(context);
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          // padding: EdgeInsets.zero,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: ProfileClipper(),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1578632749014-ca77efd052eb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGFuaW1lfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                    height: MediaQuery.of(context).size.height * 0.265,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 3.0, color: Colors.blue),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0)
                      ],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        height: 120,
                        imageUrl:
                            'https://i.pinimg.com/236x/81/70/21/81702128c4248529f9dc6e7506432004.jpg',
                        fit: BoxFit.cover,
                        width: 120,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              CurrentUser.username,
              style: GoogleFonts.lobster(
                fontSize: 30,
                color: Colors.black54,
              ),
            ),
            IconButton(
                onPressed: () => ApiServices.getCurrentUser(context: context),
                icon: const Icon(Icons.add)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // IconButton(
                //   onPressed: () {
                //     // CurrentUser.profileImage = 'hey';

                //     print(CurrentUser.likes.toList());
                //   },
                //   icon: const Icon(Icons.post_add),
                // ),
                ProfileColumnWidget(
                    text: 'Followers',
                    text2: 'CurrentUser.followers.length.toString()'),
                SizedBox(
                  width: 20,
                ),
                ProfileColumnWidget(
                    text: 'Following',
                    text2: 'CurrentUser.following.length.toString()'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      onPressed: () => navPush(context, const EditProfile()),
                      child: Text(
                        AppLocalizations.of(context)!.editProfile,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: AppColors.secondary,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.grid_3x3,
                    color: Colors.black54,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person_2_outlined,
                    color: Colors.black54,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Colors.black54,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Expanded(
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
}

class ProfileColumnWidget extends StatelessWidget {
  final String text;
  final String text2;
  const ProfileColumnWidget({
    super.key,
    required this.text,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.lobster(fontSize: 24, color: Colors.black54),
        ),
        Text(
          text2,
          style: GoogleFonts.lato(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }
}
