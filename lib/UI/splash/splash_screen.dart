import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
//todo SingleTickerProviderStateMixin=> allow AnimationController to work without not work
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //todo controls animation duration
  late AnimationController controller;

  //todo Responsible for transparent
  late Animation<double> fadeAnimation;

  //todo Responsible for zoom in and out
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    //todo create controller
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    //todo create fadeAnimation
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    //todo create scaleAnimation
    scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));

    //todo repeat=> animation automatically repeats itself after finishes
    controller.repeat(reverse: true);

    //todo navigation logic (token + role)
    Future.delayed(Duration(seconds: 3), () async {
      final token = await PrefHelper.getToken();
      final role = await PrefHelper.getRole();
      print("TOKEN => $token");
      print("ROLE => $role");

      if (token == null) {
        Navigator.pushReplacementNamed(context, AppRoute.loginScreen);
      } else {
        if (role == 'technical') {
          Navigator.pushReplacementNamed(context, AppRoute.craftManRootScreen);
        } else {
          Navigator.pushReplacementNamed(context, AppRoute.customerRootScreen);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundBlue,
      body: Center(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Image.asset(AppAssets.logoIsWhite),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
