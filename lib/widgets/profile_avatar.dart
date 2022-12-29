import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final bool addStory;
  final bool hasBorder;
  final double radius;
  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    this.isActive = false,
    this.addStory = true,
    this.hasBorder = false,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: hasBorder ? 30.0 : radius,
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(
              imageUrl,
            ),
          ),
        ),

        isActive
            ? Positioned(
                bottom: 37.0,
                right: 0.0,
                child: Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                    // color: Palette.online,
                    shape: BoxShape.circle,
                    border: Border.all(width: 2.0, color: Colors.white),
                  ),
                ),
              )
            : const SizedBox.shrink(),

        // Positioned(
        //   bottom: 0.0,
        //   child: Text(
        //     addStory ? 'Add to Story' : currentUser.name,
        //     style: const TextStyle(
        //         color: Colors.black, fontWeight: FontWeight.bold),
        //     maxLines: 1,
        //     overflow: TextOverflow.ellipsis,
        //   ),
        // )
      ],
    );
  }
}
