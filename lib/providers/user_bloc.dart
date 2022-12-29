import 'dart:async';

import 'package:anime_app/providers/bloc.dart';

import '../models/user.dart';

class UserBloc extends Bloc {
  final userController = StreamController<List<User>>.broadcast();

  @override
  void dispose() {
    userController.close();
  }
}

UserBloc userBloc = UserBloc();
