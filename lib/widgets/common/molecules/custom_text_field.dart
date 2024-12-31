import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String placeholder;
  final bool isPassword;
  final Widget? suffixIcon;
  final String? helperText;
  final Color? helperTextColor;
  final TextInputAction? action;
  final TextAlign? textAlign;
  final int? maxLength;
  final TextInputType? type;
  final Function(String)? onChange;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.placeholder,
    this.isPassword = false,
    this.suffixIcon,
    this.helperText,
    this.helperTextColor,
    this.action,
    this.onChange,
    this.textAlign,
    this.maxLength,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final borderSide = BorderSide(
      color: Colors.white.withValues(
        alpha: 0.10,
      ),
      width: 1,
    );

    return Column(
      spacing: 5,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: theme.textTheme.labelMedium,
          ),
        ),
        TextField(
          textAlign: textAlign ?? TextAlign.left,
          controller: controller,
          onChanged: onChange,
          keyboardType: type ?? TextInputType.text,
          obscureText: isPassword,
          maxLength: maxLength,
          style: theme.textTheme.labelMedium,
          textInputAction: action ?? TextInputAction.done,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            helperText: helperText,
            helperStyle: theme.textTheme.labelMedium!.copyWith(
              color: helperTextColor ?? Colors.white60,
            ),
            label: Text(
              placeholder,
              style:
                  theme.textTheme.labelMedium!.copyWith(color: Colors.white60),
            ),
            counterText: "",
            enabledBorder: OutlineInputBorder(
              borderSide: borderSide,
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              gapPadding: 2,
              borderSide: borderSide,
            ),
          ),
        ),
      ],
    );
  }
}
