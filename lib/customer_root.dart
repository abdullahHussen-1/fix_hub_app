import 'package:fix_hub/UI/chat/chat_screen.dart';
import 'package:fix_hub/UI/auth/screens/profile_screen.dart';
import 'package:fix_hub/UI/home/screens/category_screen.dart';
import 'package:fix_hub/UI/tasks/tasks_screen.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerRoot extends StatefulWidget {
  const CustomerRoot({super.key});

  @override
  State<CustomerRoot> createState() => _CustomerRootState();
}

class _CustomerRootState extends State<CustomerRoot> {
  late PageController pageController;
  int currentPage = 0;
  late List<Widget> screens;

  @override
  void initState() {
    screens = [
      CategoryScreen(),
      Chatscreen(),
      ProfileScreen(),
      TasksScreen(),
    ];

    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // بيخلي البار عايم فوق الشاشة
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBackgroundBlue.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BottomNavigationBar(
            backgroundColor: AppColors.primaryBackgroundBlue,
            selectedItemColor:
                AppColors.primaryBackgroundWhite, // لون الأيقونة المختارة
            unselectedItemColor:
                Colors.white.withOpacity(0.5), // لون الأيقونة العادية
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false, // إخفاء مساحة النصوص
            showUnselectedLabels: false,
            currentIndex: currentPage,
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
              pageController.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home, size: 24),
                activeIcon:
                    Icon(CupertinoIcons.home, size: 28), // بتكبر لما نختارها
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble, size: 24),
                activeIcon: Icon(CupertinoIcons.chat_bubble, size: 28),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_sharp, size: 24),
                activeIcon: Icon(Icons.person, size: 28),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.mail, size: 24),
                activeIcon: Icon(CupertinoIcons.mail_solid, size: 28),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
