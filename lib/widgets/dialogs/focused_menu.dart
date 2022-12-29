import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class FocusedMenu extends StatelessWidget {
  final Widget widget;
  final String title1;
  final Color title1Color;
  final String title2;
  final Color title2Color;
  final Function fnc1;
  final Function fnc2;
  final IconData icon1;
  final Color icon1Color;
  final IconData icon2;
  final Color icon2Color;
  final Color backgroundColor1;
  final Color backgroundColor2;
  const FocusedMenu({
    super.key,
    required this.widget,
    required this.title1,
    required this.title2,
    required this.fnc1,
    required this.fnc2,
    required this.title1Color,
    required this.title2Color,
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.icon1,
    required this.icon2,
    required this.icon1Color,
    required this.icon2Color,
  });

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
        blurSize: 0,
        menuWidth: MediaQuery.of(context).size.width * 0.5,
        openWithTap: true,
        onPressed: () {},
        menuItems: [
          FocusedMenuItem(
              backgroundColor: backgroundColor1,
              title: Text(
                title1,
                style: TextStyle(color: title1Color),
              ),
              onPressed: fnc1,
              trailingIcon: Icon(
                icon1,
                color: icon1Color,
              )),
          FocusedMenuItem(
              title: Text(
                title2,
                style: TextStyle(color: title2Color),
              ),
              trailingIcon: Icon(
                icon2,
                color: icon2Color,
              ),
              onPressed: fnc2,
              backgroundColor: backgroundColor2),
        ],
        child: widget);
  }
}
