import 'package:fix_hub/utils/app_style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("login Screen", style: AppStyle.bold16blackTest),
      ),
    );
  }
}
