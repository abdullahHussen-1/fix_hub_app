import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactButtons extends StatelessWidget {
  const ContactButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightBlueBorder),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.chat_bubble_outline,
                          color: AppColors.primaryBackgroundBlue, size: 24),
                    ),
                  ),
                  Gap(8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightBlueBorder),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.call,
                          color: AppColors.primaryBackgroundBlue, size: 24),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.addRequestScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButtonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: CustomText(
                  text: 'Add Request',
                  fontWeight: FontWeight.bold,
                  fontsize: 14,
                  color: AppColors.primaryBackgroundWhite,
                ),
              ),
            ],
          ),
          Gap(10),
            ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.addReviewScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryButtonColor,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: CustomText(
              text: 'Add Review',
              fontWeight: FontWeight.bold,
              fontsize: 14,
              color: AppColors.primaryBackgroundWhite,
            ),
          ),
        ],
      ),
    );
  }
}
