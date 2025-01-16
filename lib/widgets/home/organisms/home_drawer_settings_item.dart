import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeDrawerSettingsItem extends StatefulWidget {
  const HomeDrawerSettingsItem({super.key});

  @override
  State<HomeDrawerSettingsItem> createState() => _HomeDrawerSettingsItemState();
}

class _HomeDrawerSettingsItemState extends State<HomeDrawerSettingsItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  bool _isDrawerOpen = false;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _sizeAnimation = Tween<double>(begin: 56.0, end: 220.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    super.initState();
  }

  void _toggleDrawer() async {
    if (_isDrawerOpen) {
      await _controller.reverse();
      setState(() {
        _isDrawerOpen = !_isDrawerOpen;
      });
    } else {
      setState(() {
        _isDrawerOpen = !_isDrawerOpen;
      });
      await _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, widget) => SizedBox(
        height: _sizeAnimation.value,
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0xFF09073A),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: _isDrawerOpen ? 10 : 0,
                    ),
                    child: SizedBox(
                      height: 50,
                      child: SvgPicture.asset(
                        "assets/icons/settings.svg",
                      ),
                    ),
                  ),
                  if (_isDrawerOpen)
                    ...List.generate(
                      4,
                      (_) => SizedBox(
                        height: 40,
                        child: Text(
                          "•",
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: const Color(0xFFB5B5B5),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: _isDrawerOpen ? 10 : 0,
                    ),
                    child: SizedBox(
                      height: 50,
                      child: GestureDetector(
                        onTap: _toggleDrawer,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Settings",
                              style: theme.textTheme.titleMedium,
                            ),
                            Icon(
                              _isDrawerOpen
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_isDrawerOpen) ...[
                    SizedBox(
                      height: 40,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Logout",
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: const Color(0xFFB5B5B5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Private Key",
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: const Color(0xFFB5B5B5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Linked Wallet",
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: const Color(0xFFB5B5B5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Delete Account",
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: const Color(0xFFB5B5B5),
                          ),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
