import 'package:anime_app/widgets/dialogs/material_dialogs.dart';
import 'package:flutter/material.dart';

import 'icon_outline_button.dart';

class DialogBtn extends StatelessWidget {
  final String message;
  final String title;
  final String text1;
  final String text2;
  final Function btn1Function;
  final Function btn2Function;
  final IconData mainIcon;
  final IconData icon1;
  final IconData icon2;
  final Color icon1Color;
  final Color icon2Color;
  final Color mainIconColor;
  final Color iconText1Color;
  final Color iconText2Color;

  const DialogBtn({
    super.key,
    required this.mainIconColor,
    required this.context,
    required this.message,
    required this.title,
    required this.text1,
    required this.text2,
    required this.btn1Function,
    required this.btn2Function,
    required this.icon1Color,
    required this.icon2Color,
    required this.iconText1Color,
    required this.iconText2Color,
    required this.icon1,
    required this.icon2,
    required this.mainIcon,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Dialogs.materialDialog(
        context: context,
        msg: message,
        title: title,
        actions: [
          IconsOutlineButton(
            onPressed: btn1Function,
            text: text1,
            iconData: icon1,
            textStyle: TextStyle(color: iconText1Color),
            iconColor: icon1Color,
          ),
          IconsOutlineButton(
            onPressed: btn2Function,
            text: text2,
            iconData: icon2,
            textStyle: TextStyle(color: iconText2Color),
            iconColor: icon2Color,
          ),
        ],
      ),
      icon: Icon(
        mainIcon,
        color: mainIconColor,
      ),
    );
  }
}
