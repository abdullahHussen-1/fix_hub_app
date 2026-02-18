import 'package:fix_hub/utils/app_colors.dart';
import 'package:fix_hub/utils/app_style.dart';
import 'package:flutter/material.dart';

typedef validator = String? Function(String?)?;

class CustemTextFormField extends StatelessWidget {
  Color borderSideColor;
  String text;
  TextStyle hintStyleText;
  TextStyle? styleText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  validator validatorfancetion;
  TextInputType? keyboardType;
  bool obscureText;
  TextEditingController? controller;
  int maxLines;
  Function(String)? onChange;

  CustemTextFormField({
    required this.text,
    required this.borderSideColor,
    required this.hintStyleText,
    this.prefixIcon,
    this.suffixIcon,
    this.styleText,
    this.validatorfancetion,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.maxLines = 1,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        enabledBorder: outlineInputBorderItem(colorBorder: borderSideColor),
        focusedBorder: outlineInputBorderItem(colorBorder: borderSideColor),

        errorBorder: outlineInputBorderItem(colorBorder: AppColors.redColor),
        focusedErrorBorder: outlineInputBorderItem(
          colorBorder: AppColors.redColor,
        ),
        errorStyle: AppStyle.error16red,
        errorMaxLines: 2,
        hintText: text,
        hintStyle: hintStyleText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      style: styleText,
      validator: validatorfancetion,
      onChanged: onChange,
    );
  }

  OutlineInputBorder outlineInputBorderItem({required Color colorBorder}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colorBorder, width: 1),
    );
  }
}
