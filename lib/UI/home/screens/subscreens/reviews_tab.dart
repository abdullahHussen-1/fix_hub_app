// lib/UI/home/screens/subscreens/reviews_tab.dart

import 'package:fix_hub/UI/addReview/data/reviewModel.dart';
import 'package:fix_hub/UI/home/data/models/craftsmans_model.dart'; // تأكد من استيراد الموديل
import 'package:fix_hub/UI/home/widgets/custom_review_card.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';
import 'package:flutter/material.dart';

class ReviewsTab extends StatefulWidget {
  const ReviewsTab({super.key});

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  List<ReviewModel> reviews = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // الحصول على بيانات الفني من الصفحة الأب (CraftsMansDetails)
    final tech = ModalRoute.of(context)!.settings.arguments as Technician;
    loadReviews(tech.id);
  }

  Future<void> loadReviews(String techId) async {
    // استخدام الدالة التي قمت بإنشائها مسبقاً في PrefHelper
    final data = await PrefHelper.getReviewsByTech(techId);
    setState(() {
      reviews = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (reviews.isEmpty) {
      return const Center(
        child: Text("No reviews for this technician yet."),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];

        return ReviewCard(
          userName: review.userName,
          rating: review.rating,
          date: review.date,
          reviewText: review.comment,
        );
      },
    );
  }
}
