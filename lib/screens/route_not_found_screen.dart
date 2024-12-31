import 'package:flutter/material.dart';

class RouteNotFoundScreen extends StatelessWidget {
  final Uri route;

  const RouteNotFoundScreen({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Center(
            child: Text(
              'No route found for path $route',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
