import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/core/constants/app_style.dart';
import 'package:fix_hub/shared/custem_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custem_text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

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
            Image.asset(AppAssets.logoIsBlue),
            SizedBox(
              height: AppMediaQuery.sizeHeight(context) * 0.1,
            ),
            Text(
              "Phone Number:",
              style: AppStyle.bold16blackTest,
            ),
            SizedBox(
              height: AppMediaQuery.sizeHeight(context) * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppMediaQuery.sizeWidth(context) * 0.04),
              child: Form(
                key: _formkey,
                child: CustemTextFormField(
                  keyboardType: TextInputType.phone,
                  text: 'Enter Phone Number',
                  borderSideColor: AppColors.primaryBackgroundBlue,
                  controller: phoneController,
                ),
              ),
            ),
            SizedBox(
              height: AppMediaQuery.sizeHeight(context) * 0.05,
            ),
            CustemElevatedButton(
              text: "Send Verification Code",
              backGroundColor: AppColors.blackColor,
              onPressed: CheckPassword,
            )
          ],
        ),
      ),
    );
  }

  void CheckPassword() {
    //if (_formKey.currentState!.validate()) {}
  }
}
