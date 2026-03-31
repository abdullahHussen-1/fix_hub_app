
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';

class CustomLabelText extends StatelessWidget {
  const CustomLabelText({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
      child:CustomText(text: text, fontsize: 14, fontWeight: FontWeight.w400, color: AppColors.blackColor)
    );
  }
}