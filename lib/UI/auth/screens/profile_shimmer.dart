import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // todo=> image
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              alignment: Alignment.centerRight,
              child: const CircleAvatar(
                radius: 75,
                backgroundColor: Colors.white,
              ),
            ),
          ),

          const Gap(20),

          /// todo => list text from field
          ...List.generate(6, (index) => _buildField()),

          const Gap(10),

          /// todo=> Row (City + DOB)
          Row(
            children: [
              Expanded(child: _buildField()),
              const Gap(15),
              Expanded(child: _buildField()),
            ],
          ),

          const Gap(10),

          _buildField(),

          const Gap(10),

          _buildField(),
        ],
      ),
    );
  }

  Widget _buildField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// todo=> Label
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 12,
              width: 100,
              color: Colors.white,
            ),
          ),

          const Gap(6),

          /// todo=> TextField
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
