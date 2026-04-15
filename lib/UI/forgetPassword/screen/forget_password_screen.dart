import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/core/constants/app_style.dart';
import 'package:fix_hub/shared/custem_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custem_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmedPasswordController =
      TextEditingController();

  int step = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppMediaQuery.sizeWidth(context) * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logoIsBlue)
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: true))
                .fade(duration: 6.seconds)
                .scale(),
            SizedBox(
              height: AppMediaQuery.sizeHeight(context) * 0.1,
            ),
            Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (step == 1) ...{
                      Text(
                        "Phone Number:",
                        style: AppStyle.bold16blackTest,
                      ).animate().fade(duration: 800.ms).scale(
                          delay: (step * 100).ms,
                          duration: 600.ms,
                          curve: Curves.decelerate),
                      SizedBox(
                        height: AppMediaQuery.sizeHeight(context) * 0.01,
                      ),
                      CustemTextFormField(
                        keyboardType: TextInputType.phone,
                        text: 'Enter Phone Number',
                        borderSideColor: AppColors.primaryBackgroundBlue,
                        controller: phoneController,
                        validator: (vale) {
                          if (vale!.isEmpty) {
                            return "Please Fill Enter Phone Number";
                          }
                          if (vale!.length < 11 || vale.length > 11) {
                            return "The number you entered is incorrect";
                          }
                          return null;
                        },
                      ).animate().fade(duration: 800.ms).scale(
                          delay: (step * 100).ms,
                          duration: 600.ms,
                          curve: Curves.decelerate),
                      SizedBox(
                        height: AppMediaQuery.sizeHeight(context) * 0.01,
                      ),
                    },
                    if (step == 2) ...{
                      Text(
                        "Code:",
                        style: AppStyle.bold16blackTest,
                      ).animate().fade(duration: 800.ms).scale(
                          delay: (step * 100).ms,
                          duration: 600.ms,
                          curve: Curves.decelerate),
                      SizedBox(
                        height: AppMediaQuery.sizeHeight(context) * 0.01,
                      ),
                      CustemTextFormField(
                        keyboardType: TextInputType.phone,
                        text: 'Enter Code',
                        borderSideColor: AppColors.primaryBackgroundBlue,
                        controller: codeController,
                      ).animate().fade(duration: 800.ms).scale(
                          delay: (step * 100).ms,
                          duration: 600.ms,
                          curve: Curves.decelerate),
                      SizedBox(
                        height: AppMediaQuery.sizeHeight(context) * 0.01,
                      ),
                    },
                    if (step == 3) ...{
                      Text(
                        "New Password:",
                        style: AppStyle.bold16blackTest,
                      ).animate().fade(duration: 800.ms).scale(
                          delay: (step * 100).ms,
                          duration: 600.ms,
                          curve: Curves.decelerate),
                      SizedBox(
                        height: AppMediaQuery.sizeHeight(context) * 0.01,
                      ),
                      CustemTextFormField(
                              keyboardType: TextInputType.phone,
                              text: 'Enter New Password',
                              borderSideColor: AppColors.primaryBackgroundBlue,
                              controller: newPasswordController,
                              obscureText: true,
                              validator: (val) {
                                if (val!.trim().isEmpty) {
                                  return "Please Fill Enter New Password";
                                }
                                final bool passwordValid = RegExp(
                                  r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#\$&*~]{8,}$',
                                ).hasMatch(val);
                                if (val.length < 8) {
                                  return "please Enter Password Greater 8 Number";
                                }
                                if (!passwordValid) {
                                  return "Please Enter Password Contains number uppercase or lowercase letter and symbols";
                                }
                                return null;
                              })
                          .animate()
                          .fade(duration: 800.ms)
                          .scale(
                              delay: (step * 100).ms,
                              duration: 600.ms,
                              curve: Curves.decelerate),
                      SizedBox(
                        height: AppMediaQuery.sizeHeight(context) * 0.01,
                      ),
                      Text(
                        "Confirmed Password:",
                        style: AppStyle.bold16blackTest,
                      ).animate().fade(duration: 800.ms).scale(
                          delay: (step * 100).ms,
                          duration: 600.ms,
                          curve: Curves.decelerate),
                      SizedBox(
                        height: AppMediaQuery.sizeHeight(context) * 0.01,
                      ),
                      CustemTextFormField(
                        keyboardType: TextInputType.phone,
                        text: 'Enter Confirmed Password',
                        borderSideColor: AppColors.primaryBackgroundBlue,
                        controller: confirmedPasswordController,
                        obscureText: true,
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return "Please Fill Enter Confirmed Password";
                          }
                          if (val != newPasswordController.text) {
                            return "Please Enter The Matching Password";
                          }
                          return null;
                        },
                      ).animate().fade(duration: 800.ms).scale(
                          delay: (step * 100).ms,
                          duration: 600.ms,
                          curve: Curves.decelerate),
                    },
                  ],
                )),
            SizedBox(
              height: AppMediaQuery.sizeHeight(context) * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: CustemElevatedButton(
                text: step == 1
                    ? "Send Verification Code"
                    : step == 2
                        ? "Confirm Code"
                        : "Reset Password",
                backGroundColor: AppColors.blackColor,
                onPressed: CheckPassword,
              ),
            )
          ],
        ),
      ),
    );
  }

  void CheckPassword() {
    if (_formkey.currentState!.validate()) {
      if (step == 1) {
        setState(() {
          step = 2;
        });
      } else if (step == 2) {
        setState(() {
          step = 3;
        });
      } else if (step == 3) {}
    }
  }
}
