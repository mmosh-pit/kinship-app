import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          SvgPicture.asset(
            "assets/icons/kinship_main_icon.svg",
            height: 50,
          ),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.notifications_on,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
