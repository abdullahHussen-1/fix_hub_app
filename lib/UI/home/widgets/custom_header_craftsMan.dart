import 'package:fix_hub/UI/home/data/models/craftsmans_model.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomHeaderCraftsman extends StatelessWidget {
  final Technician tech;

  const CustomHeaderCraftsman({super.key, required this.tech});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primaryBackgroundBlue,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        Gap(8),

        ///  الاسم الحقيقي
        CustomText(
          text: tech.name,
          fontsize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.lightGreyBlue,
        ),

        const Gap(4),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on,
                size: 18, color: AppColors.primaryButtonColor),
            Gap(4),
            CustomText(
              text: tech.city,
              fontsize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.lightGreyBlue,
            ),
          ],
        ),
      ],
    );
  }
}
