import 'package:fix_hub/UI/chat/chat_screen.dart';
import 'package:fix_hub/UI/home/category_screen.dart';
import 'package:fix_hub/UI/profile/profile_screen.dart';
import 'package:fix_hub/UI/tasks/tasks_screen.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController pageController;
  int currentPage = 0;
  late List<Widget> screens;
  @override
  void initState() {
    // TODO: implement initState
    screens = [
      CategoryScreen(),
      Chatscreen(),
      TasksScreen(),
      ProfileScreen(),
    ];
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: pageController, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryBackgroundBlue,
            borderRadius: BorderRadius.circular(30)),
        margin: EdgeInsets.all(30),
        child: BottomNavigationBar(
            selectedItemColor: AppColors.transparentColor,
            unselectedItemColor: AppColors.primaryButtonColor,
            elevation: 0,
            currentIndex: currentPage,
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
              pageController.jumpToPage(currentPage);
            },
            backgroundColor: AppColors.primaryBackgroundBlue,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.task), label: ''),
            ]),
      ),
    );
  }
}
