import 'dart:typed_data';

import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final Uint8List? imageBytes;
  final double radius;
  final String fallbackText;

  const AvatarImage({
    super.key,
    required this.imageBytes,
    required this.radius,
    required this.fallbackText,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,

      backgroundColor:
          const Color(0xFF5B55A3),

      backgroundImage:
          imageBytes != null
              ? MemoryImage(imageBytes!)
              : null,

      child: imageBytes == null
          ? Text(
              fallbackText
                  .substring(0, 1)
                  .toUpperCase(),

              style: TextStyle(
                fontSize: radius * 0.7,
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
              ),
            )
          : null,
    );
  }
}