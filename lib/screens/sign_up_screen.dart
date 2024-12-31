import 'package:ai_app/provider/auth_provider.dart';
import 'package:ai_app/utils/routes.dart';
import 'package:ai_app/widgets/common/molecules/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenDim = MediaQuery.sizeOf(context);

    final provider = ref.watch(asyncAuthProvider);

    final isLoading = provider.isLoading;

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
                        "Sign Up",
                        style: theme.textTheme.headlineSmall,
                      ),
                      Column(
                        spacing: 15,
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            title: "First Name or Alias",
                            placeholder: "Enter your name...",
                          ),
                          CustomTextField(
                            controller: _emailController,
                            title: "Email Address",
                            placeholder: "Enter your email address...",
                          ),
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
                          ),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            isPassword: !_isConfirmPasswordVisible,
                            suffixIcon: InkWell(
                              onTap: toggleConfirmPasswordVisibility,
                              child: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                            title: "Confirm Password",
                            placeholder: "Confirm your Password...",
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 10,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (isLoading) return;
                              ref
                                  .read(asyncAuthProvider.notifier)
                                  .getCode(
                                    emailAddress: _emailController.text,
                                    password: _passwordController.text,
                                    confirmPassword:
                                        _confirmPasswordController.text,
                                  )
                                  .then(
                                (_) {
                                  if (!context.mounted) return;
                                  GoRouter.of(context)
                                      .push(Routes.codeRoute, extra: {
                                    "name": _nameController.text,
                                    "email": _emailController.text,
                                    "password": _passwordController.text,
                                  });
                                },
                              );
                            },
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : Text(
                                    "Sign Up",
                                    style: theme.textTheme.labelLarge,
                                  ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              GoRouter.of(context).push(Routes.loginRoute);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.tertiary,
                              side: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.22),
                                  width: 1),
                            ),
                            child: Text(
                              "Have an account?",
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
      ),
    );
  }
}
