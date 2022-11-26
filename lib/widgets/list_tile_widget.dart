import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onClicked;
  const ListTileWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        leading: Icon(
          icon,
          size: 28,
          color: Colors.black,
        ),
        onTap: onClicked,
      );
}
