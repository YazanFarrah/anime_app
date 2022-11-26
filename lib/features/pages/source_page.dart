import 'package:anime_app/widgets/gallery_button_widg.dart';
import 'package:flutter/material.dart';

import '../../widgets/camera_button_widget.dart';

class SourcePage extends StatelessWidget {
  const SourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Source'),
      ),
      body: ListView(
        children: const [
          CameraButtonWidget(),
          GalleryButtonWidget(),
        ],
      ),
    );
  }
}
