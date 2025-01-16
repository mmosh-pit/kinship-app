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
          // Row(
          //   spacing: 10,
          //   children: [
          //     if (profileImage.isNotEmpty)
          //       CachedNetworkImage(
          //         imageUrl: profileImage,
          //         imageBuilder: (context, imageProvider) => Container(
          //           width: 40.0,
          //           height: 40.0,
          //           margin: const EdgeInsets.only(left: 5),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             image: DecorationImage(
          //               image: imageProvider,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //       ),
          //     Container(
          //       decoration: BoxDecoration(
          //         gradient: const LinearGradient(
          //           colors: [
          //             Color(0xFFD858BC),
          //             Color(0xFF3C00FF),
          //           ],
          //         ),
          //         borderRadius: BorderRadius.circular(16),
          //       ),
          //       child: Consumer(
          //         builder: (_, ref, __) => ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.transparent,
          //             elevation: 0,
          //           ),
          //           onPressed: () {
          //             ref.read(asyncAuthProvider.notifier).logout();
          //           },
          //           child: Text(
          //             "Log Out",
          //             style: Theme.of(context).textTheme.bodyMedium,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
