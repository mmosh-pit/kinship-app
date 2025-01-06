import 'package:bigagent/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SelectLoginScreen extends StatelessWidget {
  const SelectLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenDim = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: screenDim.height * 0.15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 40,
            children: <Widget>[
              SvgPicture.asset("assets/icons/kinship_main_icon.svg"),
              SizedBox(
                width: screenDim.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      "Get Started",
                      style: theme.textTheme.headlineSmall,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).push(Routes.loginRoute);
                          },
                          child: Text(
                            "Log In",
                            style: theme.textTheme.labelLarge,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).push(Routes.signupRoute);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.tertiary,
                            side: BorderSide(
                              color: Colors.white.withValues(alpha: 0.22),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "Sign Up",
                            style: theme.textTheme.labelLarge,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
