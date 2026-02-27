import 'package:fix_hub/utils/app_assets.dart';
import 'package:fix_hub/utils/app_colors.dart';
import 'package:fix_hub/utils/app_route.dart';
import 'package:fix_hub/utils/app_style.dart';
import 'package:fix_hub/widget/custem_elevated_button.dart';
import 'package:fix_hub/widget/custem_text_form_field.dart';
import 'package:fix_hub/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController gmailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryButtonColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset(AppAssets.logoIsblue)),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: CustomText(
                        text: 'User : ',
                        fontsize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustemTextFormField(
                      text: 'Enter Your Gmail',
                      borderSideColor: AppColors.primaryBackgroundBlue,
                      hintStyleText:
                          TextStyle(color: AppColors.primaryBackgroundBlue),
                      obscureText: false,
                      suffixIcon: Icon(CupertinoIcons.eye),
                      controller: gmailController,
                    ),
                  ),
                  Gap(10),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: CustomText(
                        text: 'Password : ',
                        fontsize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:  CustemTextFormField(
                      text: 'Enter Your Password',
                      borderSideColor: AppColors.primaryBackgroundBlue,
                      hintStyleText:
                          TextStyle(color: AppColors.primaryBackgroundBlue),
                      obscureText: true,
                      suffixIcon: Icon(CupertinoIcons.eye,color: AppColors.primaryBackgroundBlue,size: 15,),
                      controller: passController,
                    ),
                  ),
                  Gap(20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoute.forgotPasswordScreen);
                      },
                      child: CustomText(
                          text: 'Forget your password?',
                          fontsize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                  Gap(10),
                  Center(
                    child: CustemElevatedButton(
                      text: "Sign In",
                      backGroundColor: AppColors.primaryButtonColor,
                      checkIcon: false,
                      child: Center(
                          child: CustomText(
                              text: 'Sign In',
                              fontsize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.white)),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.homeScreen);
                      },
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoute.registerScreen);
                        },
                        child: CustomText(
                            text: 'Sign Up',
                            fontsize: 15,
                            fontWeight: FontWeight.normal,
                            color: AppColors.blackColor)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
