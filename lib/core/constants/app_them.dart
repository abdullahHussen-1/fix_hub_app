import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppThem {
  static final ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryBackgroundWhite,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.primaryBackgroundBlue,
    ),
  );
}
