import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleAvatarImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;

  const CircleAvatarImage({
    super.key,
    required this.image,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder:
          (context, imageProvider) => Container(
            width: width ?? 40.0,
            height: height ?? 40.0,
            margin: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
    );
  }
}
