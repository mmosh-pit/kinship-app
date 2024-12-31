import 'package:ai_app/provider/auth_provider.dart';
import 'package:ai_app/widgets/common/molecules/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenDim = MediaQuery.sizeOf(context);

    final authProvider = ref.watch(asyncAuthProvider);
    final isLoading = authProvider.isLoading;
    final error = authProvider.error;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: screenDim.height * 0.10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 40,
              children: <Widget>[
                SvgPicture.asset("assets/icons/kinship_main_icon.svg"),
                SizedBox(
                  width: screenDim.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Text(
                        "Log In",
                        style: theme.textTheme.headlineSmall,
                      ),
                      Column(
                        spacing: 15,
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            title: "Email Address",
                            placeholder: "Enter your email address...",
                            helperText:
                                error.toString().contains("user_not_exists")
                                    ? "User does not exists"
                                    : null,
                            helperTextColor: Colors.red,
                          ),
                          Column(
                            spacing: 5,
                            children: [
                              CustomTextField(
                                controller: _passwordController,
                                isPassword: !_isPasswordVisible,
                                suffixIcon: InkWell(
                                  onTap: togglePasswordVisibility,
                                  child: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white,
                                  ),
                                ),
                                title: "Password",
                                placeholder: "Enter your password...",
                                helperText: error
                                        .toString()
                                        .contains("invalid_password")
                                    ? "Invalid password"
                                    : null,
                                helperTextColor: Colors.red,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forgot Password?",
                                    style:
                                        theme.textTheme.labelMedium!.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white70,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 10,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_emailController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
                                return;
                              }

                              ref.read(asyncAuthProvider.notifier).login(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                            },
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : Text(
                                    "Log In",
                                    style: theme.textTheme.labelLarge,
                                  ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/sign-up");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.tertiary,
                              side: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.22),
                                  width: 1),
                            ),
                            child: Text(
                              "Sign Up",
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
