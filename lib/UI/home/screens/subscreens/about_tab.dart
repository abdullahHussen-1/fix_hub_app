import 'package:fix_hub/UI/home/data/models/craftsmans_model.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AboutTab extends StatelessWidget {
  final Technician tech;

  const AboutTab({super.key, required this.tech});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBackgroundBlue,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Specialty: ${tech.specialty}",
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.primaryBackgroundBlue,
            ),
          ),
        ],
      ),
    );
  }
}
