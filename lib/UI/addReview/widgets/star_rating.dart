import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final Function(int) onRatingSelected;
  final double iconSize;

  const StarRating({
    super.key,
    required this.rating,
    required this.onRatingSelected,
    this.iconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () => onRatingSelected(index + 1),
          icon: Icon(
            Icons.star,
            size: iconSize,
            color: index < rating
                ? AppColors.primaryBackgroundBlue
                : AppColors.lightBlueBorder
          ),
        );
      }),
    );
  }
}
