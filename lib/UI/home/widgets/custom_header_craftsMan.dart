import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomHeaderCraftsman extends StatelessWidget {
  const CustomHeaderCraftsman({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage:
              AssetImage(AppAssets.logoIsWhite), // مثال لصورة بروفايل
          backgroundColor: AppColors.primaryBackgroundBlue, // لجعلها بدون إطار
        ),
        Gap(8),
        const CustomText(
            text: 'Amir',
            fontsize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBackgroundBlue),
        const Gap(4),
        // todo التقييم الرقمي والنجمة
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CustomText(
                text: '0.0',
                fontsize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryButtonColor),
            Gap(4),
            Icon(Icons.star, color: AppColors.primaryBackgroundBlue, size: 20),
          ],
        ),
      ],
    );
  }
}
