import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final VoidCallback executeSearch;
  final TextEditingController controller;
  final double width;
  final double height;

  const CustomSearchField({
    super.key,
    required this.controller,
    required this.executeSearch,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: const Color(0xFFC2C2C2).withValues(alpha: 0.16),
        ),
      ),
      width: width,
      height: height,
      child: Row(
        children: [
          GestureDetector(
            onTap: executeSearch,
            child: Container(
              decoration: BoxDecoration(
                // color: const Color(0xFF5A00FF),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.search, color: Colors.white),
            ),
          ),
          SizedBox(
            width: width * 0.80,
            height: height,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                hintText: "Type your search terms",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
