import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustemTextFormField extends StatefulWidget {
  Color borderSideColor;
  String ?text;
  TextStyle? hintStyleText;
  TextStyle? styleText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  bool obscureText;
  final TextEditingController controller;
  int maxLines;
  Function(String)? onChange;

  CustemTextFormField({super.key, 
     this.text,
    required this.borderSideColor,
    this.hintStyleText,
    this.prefixIcon,
    this.suffixIcon,
    this.styleText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.controller,
    this.maxLines = 1,
    this.onChange,
  });

  @override
  State<CustemTextFormField> createState() => _CustemTextFormFieldState();
}

class _CustemTextFormFieldState extends State<CustemTextFormField> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  void _togglePassword() {
    _obscureText = !_obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        cursorHeight: 15,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        controller: widget.controller,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          enabledBorder:
              outlineInputBorderItem(colorBorder: widget.borderSideColor),
          focusedBorder:
              outlineInputBorderItem(colorBorder: widget.borderSideColor),
          errorBorder: outlineInputBorderItem(colorBorder: AppColors.redColor),
          focusedErrorBorder: outlineInputBorderItem(
            colorBorder: AppColors.redColor,
          ),
          errorStyle: AppStyle.error16red,
          errorMaxLines: 2,
          hintText: widget.text,
          hintStyle: widget.hintStyleText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureText
              ? GestureDetector(
                  onTap: () {
                    _togglePassword();
                  },
                  child: widget.suffixIcon)
              : null,
        ),
        style: widget.styleText,
        validator: (v) {
          if (v == null || v.isEmpty) {
            return "please fill${widget.text}";
          }
         return null;
        },
        onChanged: widget.onChange,
      ),
    );
  }

  OutlineInputBorder outlineInputBorderItem({required Color colorBorder}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colorBorder, width: 1),
    );
  }
}
