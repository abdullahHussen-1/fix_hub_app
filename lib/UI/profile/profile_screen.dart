// lib/UI/profile/profile_screen.dart
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // متغير لمعرفة نوع المستخدم (عميل أو صنايعي)
  String userRole = 'customer';

  final nameController = TextEditingController(text: "Mohamed ahmed ali");
  final phoneController = TextEditingController(text: "+20 | 1018726435");
  final nationalIdController = TextEditingController(text: "30401595528558");
  final cityController = TextEditingController(text: "Sohag");
  final dobController = TextEditingController(text: "2003-08-18");
  final addressController =
      TextEditingController(text: "Al Kabsh, Sohag 2, Sohag Governorate");
  final roleController =
      TextEditingController(text: "Electrical Technician"); // للصنايعي فقط

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  // دالة لجلب الـ Role اللي حفظناه وقت الـ Login
  Future<void> _loadUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('user_role') ?? 'customer';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
// todo custom app header
             CustomAppbar(onTap: (){}, text: 'Edit', onPress: (){}),
              Gap(30),
              const Text(
                'Name :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gap(15),
              CustemTextFormField(
                controller: nameController,
                borderSideColor: AppColors.primaryBackgroundBlue,
              ),
               Gap(15),
              const Text(
                'Number :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gap(5),
              CustemTextFormField(
                controller: phoneController,
                borderSideColor: AppColors.primaryBackgroundBlue,
              ),
              Gap(15),
              const Text('National ID number :',
                  style: TextStyle(fontWeight: FontWeight.bold)),
               Gap(5),
              CustemTextFormField(
                controller: nationalIdController,
                borderSideColor: AppColors.primaryBackgroundBlue,
              ),
              Gap(15),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('City :',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                         Gap(5),
                        CustemTextFormField(
                          controller: cityController,
                          borderSideColor: AppColors.primaryBackgroundBlue,
                        ),
                      ],
                    ),
                  ),
                 Gap(15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Date of birth :',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Gap(5),
                        CustemTextFormField(
                          controller: dobController,
                          borderSideColor: AppColors.primaryBackgroundBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(15),

              const Text('Address :',
                  style: TextStyle(fontWeight: FontWeight.bold)),
               Gap(5),
              CustemTextFormField(
                controller: addressController,
                borderSideColor: AppColors.primaryBackgroundBlue,
              ),
              Gap(15),
// todo condition to check userRole is customer or craftsman
              if (userRole == 'craftsman') ...[
                const Text('Role / Specialty :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
                Gap(5),
                CustemTextFormField(
                  controller: roleController,
                  borderSideColor: AppColors.primaryBackgroundBlue,
                ),
                 Gap(15),
              ],
               Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
