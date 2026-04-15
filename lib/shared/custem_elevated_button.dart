import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustemElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  String text;
  Color backGroundColor;
  double? widthContainer;
  double? heightContainer;
  bool checkIcon;
  Widget? child;
  // ignore: use_key_in_widget_constructors
  CustemElevatedButton({
    this.onPressed,
    required this.text,
    required this.backGroundColor,
    this.checkIcon = false,
    this.child,
    this.heightContainer,
    this.widthContainer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: checkIcon
          ? InkWell(
              onTap: onPressed,
              child: Container(
                width: widthContainer,
                height: heightContainer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryBackgroundBlue),
                  color: backGroundColor,
                ),
                //color: AppColors.primaryButtonColor,
                padding: EdgeInsets.symmetric(
                  vertical: AppMediaQuery.sizeWidth(context) * 0.02,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: AppMediaQuery.sizeHeight(context) * 0.07,
                  horizontal: AppMediaQuery.sizeWidth(context) * 0.3,
                ),
                child: child,
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backGroundColor,
                padding: EdgeInsets.symmetric(
                  vertical: AppMediaQuery.sizeHeight(context) * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onPressed,
              child: CustomText(
                  text: text,
                  fontsize: 15,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryBackgroundWhite),
            ),
    );
  }
}
