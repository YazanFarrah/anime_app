import 'package:flutter/material.dart';

Future navPushReplacement(context, route) =>
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );

Future navPush(context, route) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => route),
    );
