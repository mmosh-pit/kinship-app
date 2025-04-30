import 'package:flutter/material.dart';

class PreReleaseText extends StatelessWidget {
  const PreReleaseText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1F0900).withValues(alpha: 0.03),
            const Color(0xFFC9C9C9).withValues(alpha: 0.30),
            const Color(0xFFC9C9C9).withValues(alpha: 0.40),
            const Color(0xFFC9C9C9).withValues(alpha: 0.60),
            const Color(0xFFFFFFFF).withValues(alpha: 0.60),
            const Color(0xFFC9C9C9).withValues(alpha: 0.60),
            const Color(0xFFC9C9C9).withValues(alpha: 0.40),
            const Color(0xFFC9C9C9).withValues(alpha: 0.30),
            const Color(0xFF2D0E01).withValues(alpha: 0.01),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.60,
          child: Text(
            "This is a pre-release system for test purposes only. Do not rely on any information you see here. If you use crypto, you might lose all your money.",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: const Color(0xFF09073A),
              height: 0.8,
              letterSpacing: 0.5,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
