import 'package:fix_hub/UI/home/screens/subscreens/about_tab.dart';
import 'package:fix_hub/UI/home/widgets/custom_contact_button.dart';
import 'package:fix_hub/UI/home/widgets/custom_header_craftsMan.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'subscreens/reviews_tab.dart';
import 'subscreens/servicesLog_tab.dart';

class CraftsMansDetails extends StatelessWidget {
  const CraftsMansDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundWhite,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: AppColors.primaryBackgroundBlue,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryBackgroundWhite,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.notifications_outlined, color: Colors.white),
            )
          ],
        ),
        body: Column(
          children: [
            Gap(10),
            const CustomHeaderCraftsman(),
            Gap(10),
            const ContactButtons(),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColors.primaryBackgroundBlue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primaryBackgroundBlue,
                tabs: const [
                  Tab(text: 'About'),
                  Tab(text: 'Reviews'),
                  Tab(text: 'Services Log'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  AboutTab(),
                  ReviewsTab(),
                  ServicesLogTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
