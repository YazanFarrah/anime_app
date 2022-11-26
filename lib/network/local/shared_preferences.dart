import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences pref;

  static setString({required key, required value}) async {
    pref = await SharedPreferences.getInstance();
    return await pref.setString(key, value);
  }

  static getString({required key}) async {
    pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static clearString({required key}) async {
    pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}
