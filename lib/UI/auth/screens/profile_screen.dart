import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:fix_hub/shared/custom_label_text.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart'; 

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userRole = 'customer';

  final nameController = TextEditingController(text: "Mohamed Ahmed Ali");
  final phoneController = TextEditingController(text: "+20 | 1018726435");
  final nationalIdController = TextEditingController(text: "30401595528558");
  final cityController = TextEditingController(text: "Sohag");
  final dobController = TextEditingController(text: "2003-08-18");
  final addressController =
      TextEditingController(text: "Al Kabsh, Sohag 2, Sohag Governorate");
  final roleController = TextEditingController(text: "Electrical Technician");

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    nationalIdController.dispose();
    cityController.dispose();
    dobController.dispose();
    addressController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundWhite,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomAppbar(
                  onTap: () {},
                  text: 'Edit',
                )
                    .animate()
                    .fade(duration: 400.ms)
                    .slideY(begin: -0.5, curve: Curves.easeOut),

                const Gap(20),

                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SizedBox(
                      width: AppMediaQuery.sizeWidth(context) - 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomLabelText(text: 'Name :'),
                          CustemTextFormField(
                            controller: nameController,
                            borderSideColor: AppColors.primaryBackgroundBlue,
                          ),
                          const Gap(10),
                          CustomLabelText(text: 'Phone Number :'),
                          CustemTextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            borderSideColor: AppColors.primaryBackgroundBlue,
                          ),
                          const Gap(10),
                          CustomLabelText(text: 'National Id Number:'),
                          CustemTextFormField(
                            keyboardType: TextInputType.number,
                            controller: nationalIdController,
                            borderSideColor: AppColors.primaryBackgroundBlue,
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLabelText(text: 'City :'),
                                    const Gap(5),
                                    CustemTextFormField(
                                      controller: cityController,
                                      borderSideColor:
                                          AppColors.primaryBackgroundBlue,
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLabelText(text: 'Date of Birth:'),
                                    const Gap(5),
                                    CustemTextFormField(
                                      controller: dobController,
                                      borderSideColor:
                                          AppColors.primaryBackgroundBlue,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          CustomLabelText(text: 'Address :'),
                          CustemTextFormField(
                            controller: addressController,
                            borderSideColor: AppColors.primaryBackgroundBlue,
                          ),
                          const Gap(10),
                          if (userRole == 'craftsman' ||
                              userRole == 'craftman') ...[
                            CustomLabelText(text: 'Specialty :'),
                            CustemTextFormField(
                              controller: roleController,
                              borderSideColor: AppColors.primaryBackgroundBlue,
                            ),
                          ],
                        ]
                            
                            .animate(interval: 40.ms)
                            .fade(duration: 400.ms)
                            .slideX(
                                begin: 0.05,
                                curve: Curves
                                    .easeOut), // بيدخلوا من اليمين شوية لليسار بنعومة
                      ),
                    ),
                  ),
                ),
                const Gap(15),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoute.loginScreen);
                    },
                    child: CustomText(
                      text: 'Logout',
                      fontsize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBackgroundBlue,
                    ),
                  ),
                )
                    .animate()
                    .fade(delay: 400.ms, duration: 400.ms)
                    .slideY(begin: 0.5, curve: Curves.easeOut),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
