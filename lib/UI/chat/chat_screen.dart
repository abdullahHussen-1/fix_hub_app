import 'package:fix_hub/UI/auth/data/user_model.dart';
import 'package:fix_hub/UI/chat/chat_list_screen.dart';
import 'package:fix_hub/UI/chat/chat_list_shimmer.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../auth/data/auth_repo.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();
  bool isLoading = true;

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: AppColors.primaryBackgroundBlue,
        elevation: 0.5,
      ),
      body: isLoading
          ? ChatListShimmer()
          : ChatListScreen(myId: userModel!.id.toString() ?? " "),
    );
  }

  Future<void> getProfileData() async {
    try {
      final result = await authRepo.getProfile();

      setState(() {
        userModel = result;
        isLoading = false;
      });
    } catch (e) {
      print("Chat error: ${e.toString()}");
    }
  }
}
