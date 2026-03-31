import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LogCard extends StatelessWidget {
  final String title;
  final String date;
  final String type;

  const LogCard({
    super.key,
    required this.title,
    required this.date,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            AppColors.lightGreyBlue, // لون خلفية كروت الأزرار من التصميم الأول
        borderRadius: BorderRadius.circular(25), // حواف دائرية كبيرة
        border: Border.all(color: AppColors.primaryBackgroundBlue.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.description_outlined,
              color: AppColors.primaryBackgroundBlue, size: 28),
      Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               CustomText(
                  text: title,
                  fontWeight: FontWeight.w400,
                  fontsize: 14,
                  color: AppColors.darkTextIcon,
                ),
              CustomText(
                  text:   '$type • $date',
                  fontWeight: FontWeight.w400,
                  fontsize: 12,
                  color: AppColors.darkTextIcon,
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              color: AppColors.primaryBackgroundBlue, size: 16),
        ],
      ),
    );
  }
}
