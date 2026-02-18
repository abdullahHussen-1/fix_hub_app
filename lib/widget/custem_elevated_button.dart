import 'package:fix_hub/utils/app_colors.dart';
import 'package:fix_hub/utils/app_media_query.dart';
import 'package:fix_hub/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustemElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  String text;
  Color backGroundColor;
  double? widthContainer;
  double? heightContainer;
  bool checkIcon;

  Widget? child;

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
      width: 20,
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
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),

              onPressed: onPressed,
              child: Text(text, style: AppStyle.error16red),
            ),
    );
  }
}
