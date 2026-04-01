//import 'package:fix_hub/UI/auth/screens/forgot_password_screen.dart';
import 'package:fix_hub/UI/addRequest/addRequest_screen.dart';
import 'package:fix_hub/UI/auth/screens/login_screen.dart';
import 'package:fix_hub/UI/auth/screens/profile_screen.dart';
import 'package:fix_hub/UI/auth/screens/register_screen.dart';
import 'package:fix_hub/UI/chat/chat_screen.dart';
import 'package:fix_hub/UI/forgetPassword/screen/forget_password_screen.dart';
import 'package:fix_hub/UI/home/screens/category_screen.dart';
import 'package:fix_hub/UI/home/screens/craftsMansList_screen.dart';
import 'package:fix_hub/UI/home/screens/craftsMans_details.dart';
import 'package:fix_hub/UI/tasks/tasks_screen.dart';
import 'package:fix_hub/UI/user_type/user_type_screen.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/core/constants/app_them.dart';
import 'package:fix_hub/customer_root.dart';
import 'package:flutter/material.dart';

import '../UI/splash/splash_screen.dart';
import 'UI/home/screens/subscreens/addReview_screen.dart';

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
          AppRoute.forgotPasswordScreen: (context) => ForgetPasswordScreen(),
          AppRoute.profileScreen: (context) => ProfileScreen(),
          AppRoute.category: (context) => CategoryScreen(),
          AppRoute.chatScreen: (context) => Chatscreen(),
          AppRoute.tasksScreen: (context) => TasksScreen(),
          AppRoute.customerRootScreen: (context) => CustomerRoot(),
          AppRoute.craftManRootScreen: (context) => CustomerRoot(),
          AppRoute.craftManListScreen: (context) => CraftsMansListScreen(),
          AppRoute.craftsMansDetailsScreen: (context) => CraftsMansDetails(),
          AppRoute.addRequestScreen: (context) => AddrequestScreen(),
          AppRoute.addReviewScreen: (context) => AddReviewScreen(),
        },
      ),
    );
  }
}
