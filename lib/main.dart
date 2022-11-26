import 'package:anime_app/network/local/shared_preferences.dart';
import 'package:anime_app/network/remote/auth-repository.dart';
import 'package:flutter/material.dart';

import 'features/auth/screens/user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthRepository.token = await CacheHelper.getString(key: 'token');
  // print(AuthRepository.token);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthRepository auth = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // routes: {AuthContainer.routeName: ((context) => AuthContainer())},
      debugShowCheckedModeBanner: false,
      title: 'Anime App',
      // theme: Pallete.darkModeAppTheme,
      home: UserState(),
      //  Provider.of<UserProvider>(context).user.token.isNotEmpty
      // ? NavScreen()
      // :
    );
  }
}
