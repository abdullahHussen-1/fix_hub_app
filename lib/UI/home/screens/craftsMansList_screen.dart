import 'package:fix_hub/UI/home/widgets/custom_craftMans_list_card.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class CraftsMansListScreen extends StatelessWidget {
  CraftsMansListScreen({super.key});
  final List<Map<String, dynamic>> craftsMans = [
    {
      'Name': 'Abd elrahman Ahmed',
      'image': Icons.person,
      'about':
          'iam ahmed is programmer senior flutter devloper lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
    },
    {
      'Name': 'Alamir Tadres',
      'image': Icons.person,
      'about':
          'iam ahmed is programmer senior flutter devloper lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
    },
    {
      'Name': 'Ahmed Mohamed',
      'image': Icons.person,
      'about':
          'iam ahmed is programmer senior flutter devloper lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
    },
    {
      'Name': 'Beshoy mina',
      'image': Icons.person,
      'about':
          'iam ahmed is programmer senior flutter devloper lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
    },
    {
      'Name': 'John Smith',
      'image': Icons.person,
      'about':
          'iam ahmed is programmer senior flutter devloper lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(onTap: () {}, text: ''),
              const Gap(20),
              //todo :  Expanded هنا لمنع كراش الـ Layout
              Expanded(
                child: ListView.builder(
                    shrinkWrap: false,
                    physics: ScrollPhysics(),
                    itemCount: craftsMans.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.craftsMansDetailsScreen,
                          );
                        },
                        child: CustomCategoryDetailesCard(
                          image: craftsMans[index]['image'],
                          name: craftsMans[index]['Name'],
                          about: craftsMans[index]['about'],
                        ),
                      ).animate().fade(duration: 800.ms).scale(
                          delay: (index * 100).ms,
                          duration: 400.ms,
                          curve: Curves.decelerate);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
