import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppThem {
  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.primaryBackgroundWhite,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.primaryBackgroundBlue,
    ),
    fontFamily: 'Roboto',
    // todo tab bar theme
    tabBarTheme: TabBarTheme(
      indicator: const UnderlineTabIndicator(
        borderSide:
            BorderSide(width: 3.0, color: AppColors.primaryBackgroundBlue),
      ),
      labelColor: AppColors.primaryBackgroundBlue,
      unselectedLabelColor: AppColors.tabBarUnselected,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      unselectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    ),
  );
}
