import 'package:fix_hub/UI/auth/data/auth_repo.dart' show AuthRepo;
import 'package:fix_hub/UI/auth/screens/profile_shimmer.dart';
import 'package:flutter/material.dart';

import '../data/user_model.dart';

class TestApi extends StatefulWidget {
  const TestApi({super.key});

  @override
  State<TestApi> createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  UserModel? user;
  bool isLoading = true;
  String? error;
  AuthRepo authRepo = AuthRepo();

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future<void> getProfileData() async {
    try {
      final result = await authRepo.getProfile();

      setState(() {
        user = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 🔥 Skeleton Loading
    if (isLoading) {
      return Scaffold(
        body: ProfileShimmer(),
      );
    }

    /// ❌ Error
    if (error != null) {
      return Scaffold(
        body: Center(child: Text(error!)),
      );
    }

    /// 📦 Data
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🖼️ صورة
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  user!.image != null ? NetworkImage(user!.image!) : null,
              child: user!.image == null
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),

            const SizedBox(height: 16),

            /// 👤 الاسم
            Text(
              user!.name ?? '',
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 8),

            Text("Phone: ${user!.phone}"),
            const SizedBox(height: 8),

            Text("City: ${user!.city}"),
            const SizedBox(height: 8),

            Text("National ID: ${user!.nationalId}"),
            const SizedBox(height: 8),

            Text("Type: ${user!.role}"),

            if (user!.profession != null)
              Text("Profession: ${user!.profession}"),
          ],
        ),
      ),
    );
  }
}

/**class TestApi extends StatefulWidget {
    TestApi({super.key});

    ApiService apiService = ApiService();

    @override
    State<TestApi> createState() => _TestApiState();
    }

    class _TestApiState extends State<TestApi> {
    @override
    Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Text("{snapshot.data!.data!.name}"),
    Text("{snapshot.data!.data!.userType}"),
    Text("{snapshot.data!.data!.city}"),
    Text("{snapshot.data!.data!.phone}"),
    Text("{snapshot.data!.data!.id}"),
    Text("{snapshot.data!.data!.createdAt}"),
    ],
    ),
    ),
    );
    }
    }*/
/*Scaffold(
      body: FutureBuilder<UserResponse>(
        future: widget.apiService.getProfile("/api/profile"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primaryBackgroundBlue,
                color: AppColors.blackColor,
              ),
            );
          }
          //todo=> error from client
          else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Something went wrong.${snapshot.error}",
                  style: AppStyle.medium16primaryTest,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blackColor,
                  ),
                  onPressed: () {
                    widget.apiService.get("/api/profile");
                    setState(() {});
                  },
                  child: Text(
                    "Try Again",
                    style: AppStyle.medium16whiteTest,
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${snapshot.data!.data!.name}"),
                Text("${snapshot.data!.data!.userType}"),
                Text("${snapshot.data!.data!.city}"),
                Text("${snapshot.data!.data!.phone}"),
                Text("${snapshot.data!.data!.id}"),
                Text("${snapshot.data!.data!.createdAt}"),
              ],
            ),
          );
        },
      ),
    );*/
