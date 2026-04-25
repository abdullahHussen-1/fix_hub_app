import 'package:fix_hub/UI/home/data/models/craftsmans_model.dart';
import 'package:fix_hub/UI/home/screens/subscreens/about_tab.dart';
import 'package:fix_hub/UI/home/widgets/custom_contact_button.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/custom_header_craftsMan.dart';
import 'subscreens/reviews_tab.dart';

class CraftsMansDetails extends StatelessWidget {
  const CraftsMansDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final tech = ModalRoute.of(context)!.settings.arguments as Technician;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundWhite,
        body: Column(
          children: [
            // --- الجزء العلوي (Header) ---
            Stack(
              children: [
                // الخلفية الزرقاء المنحنية
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBackgroundBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                // محتوى الهيدر (الاسم والصورة)
                SafeArea(
                  child: Column(
                    children: [
                      // زر الرجوع
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      CustomHeaderCraftsman(tech: tech),
                    ],
                  ),
                ),
              ],
            ),

            // --- أزرار التواصل ---
            const Gap(15),
            ContactButtons(tech: tech),
            const Gap(15),

            // --- TabBar  ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.primaryBackgroundBlue,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primaryBackgroundBlue,
                ),
                tabs: const [
                  Tab(text: 'About'),
                  Tab(text: 'Reviews'),
                ],
              ),
            ),

            // --- محتوى التابات ---
            Expanded(
              child: TabBarView(
                children: [
                  AboutTab(tech: tech),
                  const ReviewsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
