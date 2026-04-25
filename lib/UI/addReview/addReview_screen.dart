// lib/UI/addReview/screens/add_review_screen.dart

import 'package:fix_hub/UI/addReview/data/reviewModel.dart';
import 'package:fix_hub/UI/home/data/models/craftsmans_model.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
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
    final tech = ModalRoute.of(context)!.settings.arguments as Technician;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10, color: Colors.black12)
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(width: 10),
                    FutureBuilder<String?>(
                      future: PrefHelper.getUserName(),
                      builder: (context, snapshot) {
                        return CustomText(
                          text: snapshot.data ?? "User",
                          fontsize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBackgroundBlue,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: CustomText(
                  text: "Review for: ${tech.name}",
                  fontsize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryButtonColor,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: StarRating(
                  rating: selectedRating,
                  onRatingSelected: updateRating,
                  iconSize: 40,
                ),
              ),
              const SizedBox(height: 25),
              CustemTextFormField(
                controller: commentController,
                borderSideColor: AppColors.primaryBackgroundBlue,
                text: "Write your review...",
                maxLines: 4,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBackgroundBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () async {
                    if (selectedRating == 0 ||
                        commentController.text.trim().isEmpty) return;

                    // جلب اسم المستخدم الحالي
                    String name =
                        await PrefHelper.getUserName() ?? "Unknown User";

                    final review = ReviewModel(
                      technicianId: tech.id,
                      userName: name,
                      rating: selectedRating.toDouble(),
                      comment: commentController.text.trim(),
                      date:
                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    );

                    await PrefHelper.addReview(review);
                    Navigator.pop(context, true);
                  },
                  child: const CustomText(
                    text: 'Submit Review',
                    fontsize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
