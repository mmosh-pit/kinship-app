import 'package:flutter/material.dart';

class HomeDrawerHeader extends StatelessWidget {
  const HomeDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Scaffold.of(context).closeDrawer();
          },
          child: const Icon(Icons.close, color: Colors.white),
        ),
      ],
    );
  }
}
