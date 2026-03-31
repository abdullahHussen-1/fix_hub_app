import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';

SnackBar customSnackBar(String errormsg) {
  return SnackBar(
      padding: EdgeInsets.all(10),
      backgroundColor: AppColors.primaryBackgroundBlue,
      content: CustomText(
          text: errormsg,
          fontsize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryBackgroundWhite));
}
