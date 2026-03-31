import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Specialized Tech Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBackgroundBlue,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Hello, I am a specialized camera installation technician and a graphic artist with 3-5 years of experience. I provide services across all regions and am fluent in both Arabic and English. My passion is to provide innovative and high-quality solutions.',
            style: TextStyle(
                fontSize: 15, color: AppColors.primaryButtonColor, height: 1.5),
          ),
          SizedBox(height: 16),
          Text(
            'Throughout my career, I focus on accuracy, punctuality, quality of work, cleanliness after task completion, and speed of delivery. All this is to achieve client satisfaction. I am distinguished by commitment, creativity, good handling, and reasonable prices.',
            style: TextStyle(
                fontSize: 15, color: AppColors.primaryButtonColor, height: 1.5),
          ),
          SizedBox(height: 16),
          Text(
            'What makes me unique is my ability to achieve a balance between appropriate price and high quality, and to provide innovative solutions that suit clients\' needs. Trust, respect, integrity, and credibility are essential values in my work...',
            style: TextStyle(
                fontSize: 15, color: AppColors.primaryButtonColor, height: 1.5),
          ),
        ],
      ),
    );
  }
}
