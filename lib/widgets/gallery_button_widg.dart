import 'package:flutter/material.dart';

import 'list_tile_widget.dart';

class GalleryButtonWidget extends StatelessWidget {
  const GalleryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) => ListTileWidget(
        text: 'From Gallery',
        icon: Icons.camera_alt,
        onClicked: () => pickGalleryMedia(context),
      );
  Future pickGalleryMedia(BuildContext context) async {}
}
