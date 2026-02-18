import 'package:fix_hub/utils/app_assets.dart';
import 'package:fix_hub/utils/app_colors.dart';
import 'package:fix_hub/utils/app_media_query.dart';
import 'package:fix_hub/utils/app_route.dart';
import 'package:fix_hub/utils/app_style.dart';
import 'package:fix_hub/widget/custem_elevated_button.dart';
import 'package:flutter/material.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  String? SelecteValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: AppMediaQuery.sizeWidth(context) * 0.02,
          vertical: AppMediaQuery.sizeHeight(context) * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAssets.logoIsWhite),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: AppMediaQuery.sizeWidth(context) * 0.04,
              ),
              child: Text("User:", style: AppStyle.bold16blackTest),
            ),
            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: AppMediaQuery.sizeWidth(context) * 0.1,
              ),
              child: DropdownButtonFormField<String>(
                iconEnabledColor: AppColors.blackColor,
                decoration: InputDecoration(
                  labelText: SelecteValue == null ? "Choose User" : null,
                  labelStyle: AppStyle.bold16blackTest,
                  enabledBorder: outlineInputBorderItem(
                    colorBorder: AppColors.primaryBackgroundBlue,
                  ),
                  focusedBorder: outlineInputBorderItem(
                    colorBorder: AppColors.primaryBackgroundBlue,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                value: SelecteValue,

                items: ["Technical", "Costumer"]
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Center(child: Text(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    SelecteValue = value;
                  });
                },
              ),
            ),
            CustemElevatedButton(
              text: "",
              backGroundColor: AppColors.primaryButtonColor,
              checkIcon: true,
              child: Center(
                child: Text("Next", style: AppStyle.medium16whiteTest),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.loginScreen);
              },
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorderItem({required Color colorBorder}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colorBorder, width: 2),
    );
  }
}
