import 'package:anime_app/features/auth/screens/screens.dart';
import 'package:flutter/material.dart';

import '../../../network/remote/auth-repository.dart';

class UserState extends StatelessWidget {
  const UserState({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isLoggedIn
    if (AuthRepository.token != null) {
      return const NavScreen();
    } else {
      return MyLogin();
    }
  }
}
