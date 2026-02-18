import 'package:fix_hub/utils/app_assets.dart';
import 'package:fix_hub/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundBlue,
      body: Center(child: Image.asset(AppAssets.logoIsWhite)),
    );
  }
}
