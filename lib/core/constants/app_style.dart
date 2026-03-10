import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyle {
  //todo error messages
  static TextStyle error16red = TextStyle(
    fontSize: 16,
    color: AppColors.redColor,
    height: 1.5,
  );

  static TextStyle medium16primaryTest = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryButtonColor,
  );
  static TextStyle bold16blackTest = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );
  static TextStyle medium16whiteTest = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryBackgroundWhite,
  );
}
