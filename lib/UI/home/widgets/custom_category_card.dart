import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomCategoryCard extends StatelessWidget {
  const CustomCategoryCard({super.key, required this.text, required this.icon, required this.ontap});
  final String text;
  final IconData icon;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryBackgroundWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: AppColors.primaryButtonColor,
              width: 1.5,
              style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                size: 50,
               icon,
                color: AppColors.primaryBackgroundBlue),
            Gap(10),
            CustomText(
                text: text,
                fontsize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryButtonColor),
            Gap(10),
          ],
        ),
      ),
    );
  }
}
