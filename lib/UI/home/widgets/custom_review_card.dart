import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final double rating;
  final String date;
  final String reviewText;

  const ReviewCard({
    super.key,
    required this.userName,
    required this.rating,
    required this.date,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lightGreyBlue),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.lightGreyBlue,
                child:
                    Icon(Icons.person, color: AppColors.primaryBackgroundBlue),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: userName,
                    fontWeight: FontWeight.w400,
                    fontsize: 16,
                    color: AppColors.primaryButtonColor,
                  ),
                 CustomText(
                    text: date,
                    fontWeight: FontWeight.w400,
                    fontsize: 14,
                    color: AppColors.lightBlueBorder,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: index < rating
                        ? AppColors.primaryBackgroundBlue
                        : AppColors.lightBlueBorder,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          Gap(12),
          CustomText(
            text: reviewText,
            fontWeight: FontWeight.w400,
            fontsize: 14,
            color: AppColors.primaryButtonColor,
          ),
        ],
      ),
    );
  }
}
