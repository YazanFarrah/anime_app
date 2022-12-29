import 'package:anime_app/features/auth/screens/add_post.dart';
import 'package:anime_app/features/auth/screens/home_screen.dart';
import 'package:anime_app/features/auth/screens/search_screen.dart';
import 'package:anime_app/features/auth/screens/upload_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../theme/pallete.dart';
import '../../../widgets/widgets.dart';
import '../screens/screens.dart';

bool isToggle = true;

class NavScreen extends StatefulWidget {
  const NavScreen({
    super.key,
  });

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),

    //
    NotificationsScreen(),
    const ProfileScreen(),
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.search,
    FeatherIcons.bell,
    Icons.person_2_outlined,
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => navPush(context, AddPost()),
          child: const Icon(Icons.add),
        ),

        //indexed stack better than page view as it doesn't lag likepageview
        //as well as you remain to the last scroll place u were when user gets
        //back to the page

        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Card(
          color: (brightness == Brightness.light) ? Colors.transparent : null,
          elevation: 0,
          margin: const EdgeInsets.all(0),
          child: SafeArea(
            top: false,
            bottom: true,
            child: CustomTabBar(
              icons: _icons,
              selectedIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
            ),
          ),
        ),
      ),
    );
  }

  Future showToast(String message) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        fontSize: 18,
        backgroundColor: Pallete.blueColor,
        gravity: ToastGravity.TOP);
  }
}
