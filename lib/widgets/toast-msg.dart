import 'package:fluttertoast/fluttertoast.dart';

import '../theme/pallete.dart';

void showToast(String message) async {
  await Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      backgroundColor: Pallete.blueColor,
      gravity: ToastGravity.TOP);
}
