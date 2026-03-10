import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/shared/custem_elevated_button.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_text.dart';
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
                  Gap(20),
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
                      text: 'Gmail',
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
                    child: CustemTextFormField(
                      text: 'Password',
                      borderSideColor: AppColors.primaryBackgroundBlue,
                      hintStyleText:
                          TextStyle(color: AppColors.primaryBackgroundBlue),
                      obscureText: true,
                      suffixIcon: Icon(
                        CupertinoIcons.eye,
                        color: AppColors.primaryBackgroundBlue,
                        size: 15,
                      ),
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
                    child: GestureDetector(
                      onTap: () {
                        if(_formkey.currentState!.validate()){
                          print('sucess login');
                        // Navigator.pushReplacementNamed(
                        //     context, AppRoute.homeScreen);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.primaryButtonColor,
                        ),
                        child: CustomText(
                            text: 'Login',
                            fontsize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryBackgroundWhite),
                      ),
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
