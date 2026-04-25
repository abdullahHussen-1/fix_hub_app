import 'package:fix_hub/UI/home/data/models/craftsmans_model.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactButtons extends StatelessWidget {
  final Technician tech;

  const ContactButtons({super.key, required this.tech});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  /// 💬 Chat
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightBlueBorder),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // تقدر تربطها بشات بعدين
                      },
                      icon: Icon(Icons.chat_bubble_outline,
                          color: AppColors.primaryBackgroundBlue),
                    ),
                  ),

                  const Gap(8),

                  /// 📞 Call
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightBlueBorder),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        /// مؤقت: اطبع الرقم
                        print("Call: ${tech.phone}");

                        /// لو عايز بعدين:
                        /// launch("tel:${tech.phone}");
                      },
                      icon: Icon(Icons.call,
                          color: AppColors.primaryBackgroundBlue),
                    ),
                  ),
                ],
              ),

              /// 🛠 Add Request
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.addRequestScreen,
                    arguments: tech, // 👈 مهم
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButtonColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const CustomText(
                  text: 'Add Request',
                  fontWeight: FontWeight.bold,
                  fontsize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const Gap(12),

          /// ⭐ Add Review
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  AppRoute.addReviewScreen,
                  arguments: tech, // 👈 مهم
                );

                if (result == true) {
                  // 👈 عشان نعمل refresh
                  (context as Element).markNeedsBuild();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBackgroundBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const CustomText(
                text: 'Add Review',
                fontWeight: FontWeight.bold,
                fontsize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
