import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController nationalIdController = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController specialty = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap:() => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryButtonColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                onTap: () {},
                text: 'Sign In',
              ),
              Gap(20),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CustomText(
                            text: 'Name : ',
                            fontsize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustemTextFormField(
                          text: 'Your Full Name',
                          borderSideColor: AppColors.primaryBackgroundBlue,
                          hintStyleText:
                              TextStyle(color: AppColors.primaryBackgroundBlue),
                          obscureText: false,
                          suffixIcon: Icon(CupertinoIcons.eye),
                          controller: nameController,
                        ),
                      ),
                      Gap(10),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CustomText(
                            text: 'Number : ',
                            fontsize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustemTextFormField(
                          keyboardType: TextInputType.phone,
                          text: 'Phone Number',
                          borderSideColor: AppColors.primaryBackgroundBlue,
                          hintStyleText:
                              TextStyle(color: AppColors.primaryBackgroundBlue),
                          obscureText: false,
                          suffixIcon: Icon(CupertinoIcons.eye),
                          controller: numberController,
                        ),
                      ),
                      Gap(10),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CustomText(
                            text: 'National ID Number : ',
                            fontsize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustemTextFormField(
                          keyboardType: TextInputType.number,
                          text: 'Your National ID Number',
                          borderSideColor: AppColors.primaryBackgroundBlue,
                          hintStyleText:
                              TextStyle(color: AppColors.primaryBackgroundBlue),
                          obscureText: false,
                          suffixIcon: Icon(CupertinoIcons.eye),
                          controller: nationalIdController,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
