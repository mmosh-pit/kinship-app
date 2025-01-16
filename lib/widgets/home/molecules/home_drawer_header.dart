import 'package:flutter/material.dart';

class HomeDrawerHeader extends StatelessWidget {
  const HomeDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3C00FF),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(
                "2 Agents",
                style: theme.textTheme.titleMedium,
              ),
            ),
            Text(
              "•",
              style: theme.textTheme.titleMedium,
            ),
            Text(
              "Introductory",
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Scaffold.of(context).closeDrawer();
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
