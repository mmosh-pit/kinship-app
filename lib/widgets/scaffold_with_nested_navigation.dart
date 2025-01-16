import 'package:bigagent/widgets/chatbot/molecules/home_header.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:bigagent/widgets/home/molecules/home_drawer_header.dart';
import 'package:bigagent/widgets/home/molecules/home_drawer_item.dart';
import 'package:bigagent/widgets/home/organisms/home_drawer_settings_item.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  final StatefulNavigationShell shell;

  const ScaffoldWithNestedNavigation({
    super.key,
    required this.shell,
  });

  void _closeDrawer(BuildContext context) {
    Scaffold.of(context).closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.sizeOf(context).width * 0.90,
        backgroundColor: const Color(0xFF191754),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.viewPaddingOf(context).top + 20,
              left: 20,
              right: 20,
            ),
            child: Builder(
              builder: (context) {
                return Column(
                  spacing: 40,
                  children: [
                    const HomeDrawerHeader(),
                    Column(
                      spacing: 20,
                      children: [
                        HomeDrawerItem(
                          action: () {
                            shell.goBranch(0);
                            _closeDrawer(context);
                          },
                          iconPath: "assets/icons/chat.svg",
                          title: "Chat",
                        ),
                        HomeDrawerItem(
                          action: () {
                            shell.goBranch(1);
                            _closeDrawer(context);
                          },
                          iconPath: "assets/icons/agents.svg",
                          title: "Agents",
                        ),
                        HomeDrawerItem(
                          action: () {
                            shell.goBranch(2);
                            _closeDrawer(context);
                          },
                          iconPath: "assets/icons/subscriptions.svg",
                          title: "Subscriptions",
                        ),
                        const HomeDrawerSettingsItem(),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const HomeHeader(),
            shell,
          ],
        ),
      ),
    );
  }
}
