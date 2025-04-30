import 'package:flutter/material.dart';

class ChatExpandableSearch extends StatelessWidget {
  const ChatExpandableSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF010623).withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFC2C2C2).withValues(alpha: 0.56),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: const Icon(Icons.search, color: Colors.white),
    );
  }
}
