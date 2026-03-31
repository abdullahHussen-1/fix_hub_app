import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomCategoryDetailesCard extends StatelessWidget {
  const CustomCategoryDetailesCard({super.key, required this.image, required this.name, required this.about});
  final IconData image;
  final String name;
  final String about;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      //  todo : مسافة بين كل كارت والتاني
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppColors.primaryBackgroundWhite,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: AppColors.primaryBackgroundBlue,
              width: 2,
              style: BorderStyle.solid)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primaryBackgroundBlue,
            child: Icon(
              image,
              size: 50,
              color: AppColors.primaryBackgroundWhite,
            ),
          ),
          const Gap(10),
          // todo : Expanded للنصوص عشان مفيش كلام يخرج بره الشاشة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: name,
                    fontsize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBackgroundBlue),
                const Gap(10),
                CustomText(
                    maxLines: 5,
                    text:about,
                    fontsize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
