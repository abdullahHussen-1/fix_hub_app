import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/core/constants/app_style.dart';
import 'package:fix_hub/provider/provider_user_type.dart';
import 'package:fix_hub/shared/custem_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  String? selectValue;
  bool isnull = false;

  @override
  Widget build(BuildContext context) {
    var userType = Provider.of<ProviderUserType>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.sizeWidth(context) * 0.08,
          vertical: AppMediaQuery.sizeHeight(context) * 0.02,
        ),
        child: Center(
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
                height: AppMediaQuery.sizeHeight(context) * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppMediaQuery.sizeWidth(context) * 0.04,
                ),
                child: Text("Select Role:", style: AppStyle.bold16blackTest),
              ),
              SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppMediaQuery.sizeWidth(context) * 0.1,
                ),
                child: DropdownButtonFormField<String>(
                  iconEnabledColor: AppColors.blackColor,
                  decoration: InputDecoration(
                    labelText: selectValue == null ? "Choose User" : null,
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
                  value: selectValue,
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
                      selectValue = value;
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
                  userType.changeUserType(selectValue ?? " ");
                  selectValue != null
                      ? Navigator.pushNamed(
                          context, AppRoute.loginScreen /*customerRootScreen*/
                          )
                      : isnull = true;
                  print(userType.userTypeProvider);
                },
              ),
              isnull
                  ? Center(
                      child: Text(
                        "Please Enter Choose User",
                        style: AppStyle.error16red,
                      ),
                    )
                  : SizedBox()
            ],
          ),
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
