import 'package:anime_app/models/models.dart';
import 'package:anime_app/network/local/shared_preferences.dart';
import 'package:anime_app/network/remote/auth-repository.dart';
import 'package:anime_app/providers/language.dart';
import 'package:anime_app/theme/theme.dart';
import 'package:anime_app/utils/api-paths.dart';
import 'package:anime_app/utils/rest-api-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

import 'features/auth/screens/user_state.dart';
import 'l10n/ln10.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

String language = 'EN';
void main() async {
  // await Locals.
  WidgetsFlutterBinding.ensureInitialized();
  AuthRepository.token = await CacheHelper.getString(key: 'token');
  if (AuthRepository.token == null) {
    print("there's no token");
  } else {
    dynamic tokenn = JwtDecoder.decode(AuthRepository.token!);
    print(tokenn['username']);
    print(AuthRepository.token);
  }

  // AuthRepository.id = await CacheHelper.getString(key: 'userId') ?? '';
  // String tokenn = AuthRepository.token;
  // Map<String, dynamic> decodedToken = jsonEncode(AuthRepository.token!);
  // FlutterSecureStorage(decodedToken);
  // print(decodedToken);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  final AuthRepository auth = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => LanguageProvider()),
        ),
      ],
      child: GetMaterialApp(
        // routes: {AuthContainer.routeName: ((context) => AuthContainer())},
        debugShowCheckedModeBanner: false,
        title: 'Anime App',
        theme: AppTheme.light(),
        // theme: Pallete.darkModeAppTheme,
        home: const UserState(),

        //  Provider.of<UserProvider>(context).user.token.isNotEmpty
        // ? NavScreen()
        // :

        // locale: ,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
        ],
      ),
    );
    // ChangeNotifierProvider(
    //   create: (context) => LanguageProvider(),
    //   builder: (context, child) {
    //     final provider = Provider.of<LanguageProvider>(context);

    //     return

    //   },
    // );
  }
}
