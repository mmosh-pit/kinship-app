import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatbotHeader extends StatelessWidget {
  const ChatbotHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF030234),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://storage.googleapis.com/mmosh-assets/uncle-psy.png",
            ),
            CachedNetworkImage(
              imageUrl:
                  "https://storage.googleapis.com/mmosh-assets/opos-logo.png",
            ),
            CachedNetworkImage(
              imageUrl:
                  "https://storage.googleapis.com/mmosh-assets/aunt-bea.png",
            ),
          ],
        ),
      ),
    );
  }
}
