import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String address;
  final VoidCallback onReply;

  const CustomContainer({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.address,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBackgroundBlue, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///  الصورة
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(image),
          ),

          const SizedBox(width: 10),

          ///  البيانات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontsize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBackgroundBlue,
                ),

                const SizedBox(height: 5),
                CustomText(
                  text: description,
                  fontsize: 12,
                  fontWeight: FontWeight.normal,
                  color: AppColors.blackColor,
                  maxLines: 3,
                ),

                const SizedBox(height: 5),

                CustomText(
                  text: address,
                  fontsize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.darkTextIcon,
                ),

                const SizedBox(height: 10),

                ///  الأزرار
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: onReply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBackgroundBlue,
                      ),
                      child: const Text("Reply"),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
