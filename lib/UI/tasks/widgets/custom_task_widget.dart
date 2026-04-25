// lib/UI/tasks/widgets/custom_task_widget.dart

import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String name;
  final String description;
  final String address;
  final String date;
  final String time;
  final VoidCallback onReply;
  final VoidCallback onDecline;

  const CustomContainer({
    super.key,
    required this.name,
    required this.description,
    required this.address,
    required this.date,
    required this.time,
    required this.onReply,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBackgroundBlue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.primaryBackgroundBlue.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // أيقونة الشخص الشيك
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackgroundBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.primaryBackgroundBlue,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              CustomText(
                text: name,
                fontsize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBackgroundBlue,
              ),
            ],
          ),
          const Divider(height: 25, thickness: 0.5),

          // وصف المشكلة
          _buildInfoRow(Icons.report_problem, "Problem:", description),
          const SizedBox(height: 10),

          // العنوان
          _buildInfoRow(Icons.location_on, "Address:", address),
          const SizedBox(height: 10),

          // التاريخ والوقت في صف واحد
          Row(
            children: [
              Expanded(
                child: _buildInfoRow(Icons.calendar_today, "Date:", date),
              ),
              Expanded(
                child: _buildInfoRow(Icons.access_time, "Time:", time),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // أزرار التحكم (Reply & Decline)
          Row(
            children: [
              // زر الرد
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onReply,
                  icon: const Icon(Icons.chat_bubble_outline,
                      size: 18, color: Colors.white),
                  label: const Text(
                    "Reply",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBackgroundBlue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // زر الرفض
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onDecline,
                  icon: const Icon(Icons.close, size: 18, color: Colors.red),
                  label: const Text(
                    "Decline",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ودجت لتنظيم عرض المعلومات مع الأيقونات
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primaryBackgroundBlue),
        const SizedBox(width: 8),
        CustomText(
          text: label,
          fontsize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700]!,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: CustomText(
            text: value,
            fontsize: 13,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
