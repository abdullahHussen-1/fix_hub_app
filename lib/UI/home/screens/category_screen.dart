import 'package:fix_hub/UI/home/widgets/custom_category_card.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final List<Map<String, dynamic>> category = [
    {
      'title': 'Electrician',
      'icon': Icons.electrical_services_rounded,
    },
    {
      'title': 'Plumber',
      'icon': Icons.plumbing_rounded,
    },
    {
      'title': 'Carpenter',
      'icon': Icons.carpenter_rounded,
    },
    {
      'title': 'Painter',
      'icon': Icons.brush_rounded,
    },
    {
      'title': 'AC Technician',
      'icon': Icons.ac_unit_rounded,
    },
    {
      'title': 'Cleaning',
      'icon': Icons.cleaning_services_rounded,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryBackgroundWhite,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryBackgroundBlue,
            child: const Icon(Icons.psychology,
                color: Colors.white, size: 30), // أيقونة بالذكاء الاصطناعي
            onPressed: () {
              Navigator.pushNamed(context,
                  AppRoute.aiChatScreen);
            },
          ).animate().scale(delay: 1.seconds, duration: 500.ms),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(5),
                CustomAppbar(onTap: () {}, text: ''),
                Gap(10),
                GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.5),
                    itemCount: category.length,
                    itemBuilder: (contex, index) {
                      return CustomCategoryCard(
                              text: category[index]['title'],
                              icon: category[index]['icon'],
                              ontap: () {
                                Navigator.pushNamed(
                                    context, AppRoute.craftManListScreen,
                                    arguments: category[index]['title']);
                              })
                          .animate()
                          .fade(duration: 800.ms)
                          .scale(
                              delay: (index * 100).ms,
                              duration: 400.ms,
                              curve: Curves.decelerate);
                    })
              ],
            ),
          ),
        ));
  }
}
