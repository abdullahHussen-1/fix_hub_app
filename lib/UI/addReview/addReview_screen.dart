import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:gap/gap.dart';

import '../../../../shared/custem_text_form_field.dart';
import 'widgets/star_rating.dart';

class AddreviewScreen extends StatefulWidget {
  const AddreviewScreen({super.key});

  @override
  State<AddreviewScreen> createState() => _AddreviewScreenState();
}

class _AddreviewScreenState extends State<AddreviewScreen> {
  int selectedRating = 0;
  final TextEditingController commentController = TextEditingController();

  void updateRating(int index) {
    setState(() {
      selectedRating = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),

            /// 👤 Card بتاع الشخص
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryBackgroundBlue),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CustomText(
                              text: "Ramy Diab",
                              fontsize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBackgroundBlue),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            ///  النجوم الكبيرة للاختيار
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.primaryBackgroundBlue),
              ),
              child: StarRating(
                rating: selectedRating,
                onRatingSelected: updateRating,
                iconSize: 35,
              ),
            ),

            const SizedBox(height: 20),

            /// ✍️ TextField
            CustemTextFormField(
              controller: commentController,
              borderSideColor: AppColors.primaryBackgroundBlue,
              text: "Write your review",
              maxLines: 3,
            ),

            Gap(20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBackgroundBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  print("Rating: $selectedRating");
                  print("Comment: ${commentController.text}");
                },
                child: CustomText(
                    text: 'Send',
                    fontsize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBackgroundWhite)),
          ],
        ),
      ),
    );
  }
}
