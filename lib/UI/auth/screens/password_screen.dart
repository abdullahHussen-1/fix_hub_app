import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/shared/custem_elevated_button.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryButtonColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(AppAssets.logoIsblue),
                ),
                Gap(20),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: CustomText(
                      text: 'Password : ',
                      fontsize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustemTextFormField(
                    text: 'Enter Password',
                    borderSideColor: AppColors.primaryBackgroundBlue,
                    hintStyleText:
                        TextStyle(color: AppColors.primaryBackgroundBlue),
                    obscureText: false,
                    suffixIcon: Icon(CupertinoIcons.eye),
                    controller: passwordController,
                  ),
                ),
                Gap(10),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: CustomText(
                      text: 'Enter Confirmed Password : ',
                      fontsize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustemTextFormField(
                    text: 'Confirm Password',
                    borderSideColor: AppColors.primaryBackgroundBlue,
                    hintStyleText:
                        TextStyle(color: AppColors.primaryBackgroundBlue),
                    obscureText: true,
                    suffixIcon: Icon(
                      CupertinoIcons.eye,
                      color: AppColors.primaryBackgroundBlue,
                      size: 15,
                    ),
                    controller: confirmPasswordController,
                  ),
                ),
                Gap(10),
                Center(
                  child: CustemElevatedButton(
                    text: '',
                    backGroundColor: AppColors.primaryButtonColor,
                    checkIcon: true,
                    child: Center(
                      child: CustomText(
                          text: 'Sign In',
                          fontsize: 10,
                          fontWeight: FontWeight.normal,
                          color: AppColors.primaryBackgroundWhite),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoute.category);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
