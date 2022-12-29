import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

void displaySuccessMotionToast(
    BuildContext context, String msg, String description) {
  MotionToast.success(
    title: Text(
      msg,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(
      description,
      style: const TextStyle(fontSize: 12),
    ),
    layoutOrientation: ToastOrientation.rtl,
    animationType: AnimationType.fromRight,
    dismissable: true,
  ).show(context);
}

void displayWarningMotionToast(
  BuildContext context,
  String msg,
  String description,
) {
  MotionToast.warning(
    // position: MotionToastPosition.position,
    title: Text(
      msg,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: Text(description),
    animationCurve: Curves.bounceIn,
    borderRadius: 0,
    animationDuration: const Duration(milliseconds: 1000),
  ).show(context);
}

void displayErrorMotionToast(
    BuildContext context, String msg, String description) {
  MotionToast.error(
    title: Text(
      msg,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: Text(description),
    position: MotionToastPosition.top,
    barrierColor: Colors.black.withOpacity(0.3),
    width: 300,
    height: 80,
    dismissable: false,
  ).show(context);
}

void displayInfoMotionToast(
    BuildContext context, String msg, String description) {
  MotionToast.info(
    title: Text(
      msg,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    position: MotionToastPosition.center,
    description: Text(description),
  ).show(context);
}

void displayDeleteMotionToast(
    {required BuildContext context,
    required String msg,
    required String description}) {
  MotionToast.delete(
    title: Text(
      msg,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: Text(description),
    animationType: AnimationType.fromTop,
    position: MotionToastPosition.top,
  ).show(context);
}

void displayResponsiveMotionToast(
    BuildContext context, String msg, String description) {
  MotionToast(
    icon: Icons.rocket_launch,
    primaryColor: Colors.purple,
    title: Text(
      msg,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: Text(
      description,
    ),
  ).show(context);
}

void displayCustomMotionToast(
    BuildContext context, String msg, String description) {
  MotionToast(
    primaryColor: Colors.pink,
    title: Text(
      msg,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    dismissable: false,
    description: Text(description),
  ).show(context);
}

void displayMotionToastWithoutSideBar(BuildContext context) {
  MotionToast(
    icon: Icons.zoom_out,
    primaryColor: Colors.orange[500]!,
    secondaryColor: Colors.grey,
    backgroundType: BackgroundType.solid,
    title: Text('Two Color Motion Toast'),
    description: Text('Another motion toast example'),
    displayBorder: true,
    displaySideBar: false,
  ).show(context);
}

void displayMotionToastWithBorder(BuildContext context) {
  MotionToast(
    icon: Icons.zoom_out,
    primaryColor: Colors.deepOrange,
    title: const Text('Top Motion Toast'),
    description: const Text('Another motion toast example'),
    position: MotionToastPosition.top,
    animationType: AnimationType.fromTop,
    displayBorder: true,
    width: 350,
    height: 100,
    padding: const EdgeInsets.only(
      top: 30,
    ),
  ).show(context);
}

void displayTwoColorsMotionToast(BuildContext context) {
  MotionToast(
    icon: Icons.zoom_out,
    primaryColor: Colors.orange[500]!,
    secondaryColor: Colors.grey,
    backgroundType: BackgroundType.solid,
    title: const Text(
      'Two Color Motion Toast',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: const Text('Another motion toast example'),
    position: MotionToastPosition.top,
    animationType: AnimationType.fromTop,
    width: 350,
    height: 100,
  ).show(context);
}

void displayTransparentMotionToast(BuildContext context) {
  MotionToast(
    icon: Icons.zoom_out,
    primaryColor: Colors.grey[400]!,
    secondaryColor: Colors.yellow,
    backgroundType: BackgroundType.transparent,
    title: const Text(
      'Two Color Motion Toast',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: const Text('Another motion toast example'),
    position: MotionToastPosition.center,
    width: 350,
    height: 100,
  ).show(context);
}

void displaySimultaneouslyToasts(BuildContext context) {
  MotionToast.warning(
    title: const Text(
      'Warning Motion Toast',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: const Text('This is a Warning'),
    animationCurve: Curves.bounceIn,
    borderRadius: 0,
    animationDuration: const Duration(milliseconds: 1000),
  ).show(context);
  MotionToast.error(
    title: const Text(
      'Error',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: const Text('Please enter your name'),
    animationType: AnimationType.fromLeft,
    position: MotionToastPosition.top,
    width: 300,
    height: 80,
  ).show(context);
}
