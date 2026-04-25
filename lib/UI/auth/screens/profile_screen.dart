import 'dart:io';

import 'package:fix_hub/UI/auth/data/auth_repo.dart';
import 'package:fix_hub/UI/auth/screens/profile_shimmer.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/core/constants/app_style.dart';
import 'package:fix_hub/core/network/chat_services.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:fix_hub/shared/custom_label_text.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../shared/custom_snackBar.dart';
import '../data/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userRole = 'customer';

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? selectImage;
  UserModel? user;
  bool isLoading = true;
  bool isUpdating = false;
  String? error;
  AuthRepo authRepo = AuthRepo();
  FocusNode myFocusNode = FocusNode();

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
        nameController = TextEditingController(text: user!.name ?? "null");
        phoneController = TextEditingController(text: "+20 | ${user!.phone}");
        nationalIdController =
            TextEditingController(text: user!.nationalId ?? "null");
        cityController = TextEditingController(text: user!.city ?? "null");
        dobController =
            TextEditingController(text: formatDate(user!.createdAt ?? " "));
        addressController =
            TextEditingController(text: user!.address ?? "null");
        roleController =
            TextEditingController(text: user!.profession ?? "null");

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> updateProfileData() async {
    setState(() => isUpdating = true);

    try {
      final body = {
        "name": nameController.text,
        "phone": phoneController.text.replaceAll("+20 | ", ""),
        "national_id": nationalIdController.text,
        "city": cityController.text,
        "address": addressController.text,
        "profession": roleController.text
      };

      final updatedUser = await authRepo.updateProfile(body);

      setState(() {
        user = updatedUser;
        selectImage = null;

        nameController.text = user!.name ?? "";
        phoneController.text = "+20 | ${user!.phone}";
        nationalIdController.text = user!.nationalId ?? "";
        cityController.text = user!.city ?? "";
        addressController.text = user!.address ?? "null";
        roleController.text = user!.profession ?? "null";
      });
      ChatService().updateUserDataInFirebase(
          uid: updatedUser!.id.toString() ?? "null",
          name: updatedUser.name ?? "null",
          imageUrl: updatedUser.image ?? "null");
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar("Your profile has been updated successfully"));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }

    setState(() => isUpdating = false);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    nationalIdController.dispose();
    cityController.dispose();
    dobController.dispose();
    addressController.dispose();
    roleController.dispose();

    /// FocusScope.of(context).unfocus();
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
                  onTap: () {
                    if (isUpdating) {
                      //  todo=> state=> Saving
                      updateProfileData();
                      myFocusNode.unfocus();
                      setState(() {
                        isUpdating = false;
                      });
                    } else {
                      //  todo=> state=> Edit
                      myFocusNode.requestFocus();
                      setState(() {
                        isUpdating = true;
                      });
                    }
                  },
                  text: isUpdating ? 'Saving' : "Edit",
                )
                    .animate()
                    .fade(duration: 400.ms)
                    .slideY(begin: -0.5, curve: Curves.easeOut),
                const Gap(20),
                Expanded(
                  child: SizedBox(
                    width: AppMediaQuery.sizeWidth(context) - 30,
                    child: isLoading
                        ? ProfileShimmer()
                        : error != null
                            ? Center(
                                child: Text(
                                  "$error",
                                  style: AppStyle.medium16primaryTest,
                                ),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: selectImage == null
                                                  ? DecorationImage(
                                                      image: NetworkImage(
                                                          user!.image ?? ''))
                                                  : DecorationImage(
                                                      image: FileImage(File(
                                                          selectImage!.path)),
                                                      fit: BoxFit.fill)),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              final image =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              setState(() {
                                                if (image != null) {
                                                  selectImage =
                                                      File(image.path);
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.camera_alt,
                                              size: 35,
                                              color: AppColors.blackColor,
                                            ))
                                      ],
                                    ).animate().fade(duration: 400.ms).slideX(
                                        begin: 0.05, curve: Curves.easeOut),
                                    CustomLabelText(text: 'Name :')
                                        .animate()
                                        .fade(duration: 400.ms)
                                        .slideX(
                                            begin: 0.05, curve: Curves.easeOut),
                                    CustemTextFormField(
                                      readOnly: !isUpdating,
                                      focusNode: myFocusNode,
                                      controller: nameController,
                                      borderSideColor:
                                          AppColors.primaryBackgroundBlue,
                                    ).animate().fade(duration: 400.ms).slideX(
                                        begin: 0.05, curve: Curves.easeOut),
                                    const Gap(10),
                                    CustomLabelText(text: 'Phone Number :')
                                        .animate()
                                        .fade(duration: 400.ms)
                                        .slideX(
                                            begin: 0.05, curve: Curves.easeOut),
                                    CustemTextFormField(
                                      readOnly: !isUpdating,
                                      keyboardType: TextInputType.phone,
                                      controller: phoneController,
                                      borderSideColor:
                                          AppColors.primaryBackgroundBlue,
                                    ).animate().fade(duration: 400.ms).slideX(
                                        begin: 0.05, curve: Curves.easeOut),
                                    const Gap(10),
                                    CustomLabelText(text: 'National Id Number:')
                                        .animate()
                                        .fade(duration: 400.ms)
                                        .slideX(
                                            begin: 0.05, curve: Curves.easeOut),
                                    CustemTextFormField(
                                      readOnly: !isUpdating,
                                      keyboardType: TextInputType.number,
                                      controller: nationalIdController,
                                      borderSideColor:
                                          AppColors.primaryBackgroundBlue,
                                    ).animate().fade(duration: 400.ms).slideX(
                                        begin: 0.05, curve: Curves.easeOut),
                                    const Gap(10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomLabelText(text: 'City :')
                                                  .animate()
                                                  .fade(duration: 400.ms)
                                                  .slideX(
                                                      begin: 0.05,
                                                      curve: Curves.easeOut),
                                              const Gap(5),
                                              CustemTextFormField(
                                                readOnly: !isUpdating,
                                                controller: cityController,
                                                borderSideColor: AppColors
                                                    .primaryBackgroundBlue,
                                              )
                                                  .animate()
                                                  .fade(duration: 400.ms)
                                                  .slideX(
                                                      begin: 0.05,
                                                      curve: Curves.easeOut),
                                            ],
                                          ),
                                        ),
                                        const Gap(15),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomLabelText(
                                                      text: 'Date of Birth:')
                                                  .animate()
                                                  .fade(duration: 400.ms)
                                                  .slideX(
                                                      begin: 0.05,
                                                      curve: Curves.easeOut),
                                              const Gap(5),
                                              CustemTextFormField(
                                                readOnly: !isUpdating,
                                                controller: dobController,
                                                borderSideColor: AppColors
                                                    .primaryBackgroundBlue,
                                              )
                                                  .animate()
                                                  .fade(duration: 400.ms)
                                                  .slideX(
                                                      begin: 0.05,
                                                      curve: Curves.easeOut),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(10),
                                    CustomLabelText(text: 'Address :')
                                        .animate()
                                        .fade(duration: 400.ms)
                                        .slideX(
                                            begin: 0.05, curve: Curves.easeOut),
                                    CustemTextFormField(
                                      readOnly: !isUpdating,
                                      controller: addressController,
                                      borderSideColor:
                                          AppColors.primaryBackgroundBlue,
                                    ).animate().fade(duration: 400.ms).slideX(
                                        begin: 0.05, curve: Curves.easeOut),
                                    const Gap(10),
                                    if (user!.role == 'technical') ...[
                                      CustomLabelText(text: 'Specialty :')
                                          .animate()
                                          .fade(duration: 400.ms)
                                          .slideX(
                                              begin: 0.05,
                                              curve: Curves.easeOut),
                                      CustemTextFormField(
                                        readOnly: !isUpdating,
                                        controller: roleController,
                                        borderSideColor:
                                            AppColors.primaryBackgroundBlue,
                                      ).animate().fade(duration: 400.ms).slideX(
                                          begin: 0.05, curve: Curves.easeOut),
                                    ],
                                  ]
                                  /*.animate(interval: 40.ms)
                                      .fade(duration: 400.ms)
                                      .slideX(
                                          begin: 0.05,
                                          curve: Curves
                                              .easeOut)*/
                                  , // بيدخلوا من اليمين شوية لليسار بنعومة
                                ),
                              ),
                  ),
                ),
                const Gap(15),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      await AuthRepo.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoute.loginScreen, (route) => false);
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

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
