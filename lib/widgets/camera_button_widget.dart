import 'package:anime_app/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';

class CameraButtonWidget extends StatelessWidget {
  const CameraButtonWidget({super.key});

  @override
  Widget build(BuildContext context) => ListTileWidget(
        text: 'From Camera',
        icon: Icons.camera_alt,
        onClicked: () => pickCameraMedia(context),
      );
  Future pickCameraMedia(BuildContext context) async {}
}
