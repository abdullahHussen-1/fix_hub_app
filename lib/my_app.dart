//import 'package:fix_hub/UI/auth/screens/forgot_password_screen.dart';
import 'package:fix_hub/UI/auth/screens/password_screen.dart';
import 'package:fix_hub/UI/chat/chat_screen.dart';
import 'package:fix_hub/UI/home/category_screen.dart';
import 'package:fix_hub/UI/auth/screens/login_screen.dart';
import 'package:fix_hub/UI/auth/screens/register_screen.dart';
import 'package:fix_hub/UI/profile/profile_screen.dart';
import 'package:fix_hub/UI/tasks/tasks_screen.dart';
import 'package:fix_hub/UI/user_type/user_type_screen.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/core/constants/app_them.dart';
import 'package:flutter/material.dart';

import '../UI/splash/splash_screen.dart';

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
          AppRoute.passwordScreen: (context) => PasswordScreen(),
        //  AppRoute.forgotPasswordScreen: (context) => ForgotPasswordScreen(),
          AppRoute.profileScreen: (context) => ProfileScreen(),
          AppRoute.category: (context) => CategoryScreen(),
          AppRoute.chatScreen: (context) => Chatscreen(),
          AppRoute.tasksScreen: (context) => TasksScreen(),
        },
      ),
    );
  }
}
