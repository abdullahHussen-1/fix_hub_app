import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;

  const CustomAppbar({
    super.key,
    this.onTap,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.sizeWidth(context) * 0.03,
          vertical: AppMediaQuery.sizeHeight(context) * 0.01),
      decoration: BoxDecoration(
        color: AppColors.primaryBackgroundBlue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppAssets.logoIsWhite,
            width: AppMediaQuery.sizeWidth(context) * 0.4,
            height: AppMediaQuery.sizeHeight(context) * 0.1,
            fit: BoxFit.cover,
          ),
          if (text != null && text!.isNotEmpty) ...[
            InkWell(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppMediaQuery.sizeWidth(context) * 0.05,
                    vertical: AppMediaQuery.sizeHeight(context) * 0.013),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.primaryBackgroundWhite, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: CustomText(
                    text: text!,
                    fontsize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBackgroundWhite,
                  ),
                ),
              ),
            ),
            //Gap(15),
          ],
        ],
      ),
    );
  }
}
