import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustemTextFormField extends StatefulWidget {
  final Color borderSideColor;
  final String? text;
  final TextStyle? hintStyleText;
  final TextStyle? styleText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final int maxLines;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool readOnly;

  const CustemTextFormField(
      {super.key,
      this.text,
      required this.borderSideColor,
      this.hintStyleText,
      this.prefixIcon,
      this.suffixIcon,
      this.styleText,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.controller,
      this.maxLines = 1,
      this.onChange,
      this.validator,
      this.focusNode,
      this.readOnly = false});

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
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      controller: widget.controller,
      maxLines: widget.maxLines,
      style: widget.styleText ?? const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        isDense: true,
        //  بيخلي الحقل ملموم وأبسط
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        enabledBorder:
            outlineInputBorderItem(colorBorder: widget.borderSideColor),
        focusedBorder: outlineInputBorderItem(
            colorBorder: widget.borderSideColor, width: 1.5),
        errorBorder: outlineInputBorderItem(colorBorder: AppColors.redColor),
        focusedErrorBorder:
            outlineInputBorderItem(colorBorder: AppColors.redColor, width: 1.5),
        errorStyle: AppStyle.error16red.copyWith(fontSize: 12),
        errorMaxLines: 2,
        hintText: widget.text,
        hintStyle: widget.hintStyleText ??
            TextStyle(color: Colors.grey.shade400, fontSize: 13),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                  color: widget.borderSideColor,
                  size: 20,
                ),
                onPressed: _togglePassword,
              )
            : widget.suffixIcon,
      ),
      validator: widget.validator ??
          (v) {
            if (v == null || v.isEmpty) {
              return "Please fill ${widget.text ?? 'this field'}";
            }
            return null;
          },
      onChanged: widget.onChange,
    );
  }

  OutlineInputBorder outlineInputBorderItem(
      {required Color colorBorder, double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // حواف دائرية زي الصورة بالظبط
      borderSide: BorderSide(color: colorBorder, width: width),
    );
  }
}
