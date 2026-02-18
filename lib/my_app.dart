import 'package:fix_hub/UI/forgot_password/forgot_password_screen.dart';
import 'package:fix_hub/UI/home/home_screen.dart';
import 'package:fix_hub/UI/login/login_screen.dart';
import 'package:fix_hub/UI/register/register_screen.dart';
import 'package:fix_hub/UI/user_type/user_type_screen.dart';
import 'package:fix_hub/utils/app_route.dart';
import 'package:fix_hub/utils/app_them.dart';
import 'package:flutter/material.dart';

import 'UI/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FIX HUB',
        theme: AppThem.themeData,
        initialRoute: AppRoute.splashScreen,
        routes: {
          AppRoute.splashScreen: (context) => SplashScreen(),
          AppRoute.userTypeScreen: (context) => UserTypeScreen(),
          AppRoute.loginScreen: (context) => LoginScreen(),
          AppRoute.registerScreen: (context) => RegisterScreen(),
          AppRoute.forgotPasswordScreen: (context) => ForgotPasswordScreen(),
          AppRoute.homeScreen: (context) => HomeScreen(),
        },
      ),
    );
  }
}
