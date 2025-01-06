import 'package:bigagent/provider/auth_provider.dart';
import 'package:bigagent/widgets/common/molecules/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class EnterCodeScreen extends ConsumerStatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  ConsumerState<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends ConsumerState<EnterCodeScreen> {
  String name = "";
  String email = "";
  String password = "";

  @override
  void initState() {
    final extra = GoRouter.of(context).state!.extra as Map<String, dynamic>?;

    if (extra != null) {
      debugPrint("Got extra here: $extra");
      name = extra["name"];
      email = extra["email"];
      password = extra["password"];
    }

    super.initState();
  }

  final firstControllers = List.generate(
    3,
    (_) => TextEditingController(),
  );

  final secondControllers = List.generate(
    3,
    (_) => TextEditingController(),
  );

  void _verifyCode() {
    String code = "";

    for (final controller in firstControllers) {
      code += controller.text;
    }

    for (final controller in secondControllers) {
      code += controller.text;
    }

    ref.read(asyncAuthProvider.notifier).signUp(
          name: name,
          emailAddress: email,
          password: password,
          code: int.parse(code),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenDim = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: screenDim.height * 0.10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 40,
            children: [
              SvgPicture.asset("assets/icons/kinship_main_icon.svg"),
              SizedBox(
                width: screenDim.width * 0.90,
                child: Column(
                  spacing: 20,
                  children: [
                    Text(
                      "Enter Code",
                      style: theme.textTheme.headlineSmall,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        ...firstControllers.map(
                          (e) => SizedBox(
                            width: screenDim.width * 0.10,
                            child: CustomTextField(
                              controller: e,
                              type: TextInputType.number,
                              textAlign: TextAlign.center,
                              title: "",
                              maxLength: 1,
                              action: TextInputAction.next,
                              onChange: (value) {
                                if (value.isNotEmpty) {
                                  if (!FocusScope.of(context).nextFocus()) {
                                    _verifyCode();
                                    return;
                                  }
                                  return;
                                }

                                FocusScope.of(context).previousFocus();
                              },
                              placeholder: "",
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: screenDim.width * 0.05,
                          margin: EdgeInsets.symmetric(
                            horizontal: screenDim.width * 0.02,
                          ),
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                        ...secondControllers.map(
                          (e) => SizedBox(
                            width: screenDim.width * 0.10,
                            child: CustomTextField(
                              textAlign: TextAlign.center,
                              controller: e,
                              type: TextInputType.number,
                              action: TextInputAction.next,
                              maxLength: 1,
                              onChange: (value) {
                                if (value.isNotEmpty) {
                                  FocusScope.of(context).nextFocus();
                                  return;
                                }

                                FocusScope.of(context).previousFocus();
                              },
                              title: "",
                              placeholder: "",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _verifyCode,
                child: Text(
                  "Validate",
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
