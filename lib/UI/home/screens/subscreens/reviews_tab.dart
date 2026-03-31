import 'package:fix_hub/UI/home/widgets/custom_review_card.dart';
import 'package:flutter/material.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // todo قائمة تجريبية للتقييمات 
    final reviews = [
      {
        'user': 'Sara Ali',
        'rating': 5.0,
        'date': '2 Days ago',
        'text':
            'Excellent camera installation service! Very professional and clean. Highly recommended.'
      },
      {
        'user': 'Mohamed Khan',
        'rating': 4.5,
        'date': '1 Week ago',
        'text':
            'The graphic design work was fantastic. Delivered on time and met all my requirements. Great work.'
      },
      {
        'user': 'Jane Doe',
        'rating': 5.0,
        'date': '2 Weeks ago',
        'text':
            'He is punctual and very skilled in his work. Good handling and fair prices.'
      },
    ];

    return ListView.builder(
      itemCount: reviews.length,
      padding: const EdgeInsets.only(top: 8),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ReviewCard(
          userName: review['user'] as String,
          rating: review['rating'] as double,
          date: review['date'] as String,
          reviewText: review['text'] as String,
        );
      },
    );
  }
}
