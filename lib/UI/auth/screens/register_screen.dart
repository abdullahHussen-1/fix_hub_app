import 'package:fix_hub/UI/auth/data/auth_repo.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/core/network/api_error.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:fix_hub/shared/custom_dropDown.dart';
import 'package:fix_hub/shared/custom_label_text.dart';
import 'package:fix_hub/shared/custom_snackBar.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? selectedCity;
  String? selectedSpecialty;

  final List<String> cities = ['Sohag', 'Cairo', 'Alexandria', 'Aswan'];

  final List<String> specialties = [
    'Electrical Technician',
    'Plumber',
    'Carpenter',
    'Painter'
  ];

  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final user = await authRepo.register(
            nameController.text.trim(),
            numberController.text.trim(),
            nationalIdController.text.trim(),
            selectedCity.toString(),
            addressController.text,
            selectedSpecialty.toString(),
            passwordController.text,
            confirmPasswordController.text);

        if (user != null && user.role == 'customer') {
          Navigator.pushReplacementNamed(context, AppRoute.customerRootScreen);
          setState(() {
            isLoading = false;
          });
        } else if (user != null && user.role == 'craftman') {
          Navigator.pushReplacementNamed(context, AppRoute.customerRootScreen);
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        String errormsg = 'Unhandled error in Register';
        if (e is ApiError) {
          errormsg = e.message;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(errormsg),
        );
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    nationalIdController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? userType =
        (ModalRoute.of(context)?.settings.arguments as String?)
            ?.trim()
            .toLowerCase();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomAppbar(
                  onTap: () {
                    register();
                  },
                  text: 'Sign In',
                ),
                const Gap(20),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SizedBox(
                      width: AppMediaQuery.sizeWidth(context) - 20,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabelText(text: 'Name :'),
                            CustemTextFormField(
                              text: 'Your Full Name',
                              borderSideColor: AppColors.primaryBackgroundBlue,
                              controller: nameController,
                            ),
                            const Gap(10),
                            CustomLabelText(text: 'Phone Number :'),
                            CustemTextFormField(
                              keyboardType: TextInputType.phone,
                              text: '+20',
                              borderSideColor: AppColors.primaryBackgroundBlue,
                              controller: numberController,
                            ),
                            const Gap(10),
                            CustomLabelText(text: 'National ID :'),
                            CustemTextFormField(
                              keyboardType: TextInputType.number,
                              text: 'Your National ID',
                              borderSideColor: AppColors.primaryBackgroundBlue,
                              suffixIcon: userType == 'technician'
                                  ? const Icon(
                                      CupertinoIcons.camera_fill,
                                      color: Color(0xFF1E232C),
                                    )
                                  : null,
                              controller: nationalIdController,
                            ),
                            const Gap(10),
                            CustomLabelText(text: 'City :'),
                            CustomDropdownField(
                              value: selectedCity,
                              items: cities,
                              hintText: 'Select City',
                              onChanged: (value) =>
                                  setState(() => selectedCity = value),
                            ),
                            const Gap(10),
                            if (userType == 'technician') ...[
                              CustomLabelText(text: 'Specialty :'),
                              CustomDropdownField(
                                value: selectedSpecialty,
                                items: specialties,
                                hintText: 'Select Specialty',
                                onChanged: (value) =>
                                    setState(() => selectedSpecialty = value),
                              ),
                            ] else ...[
                              CustomLabelText(text: 'Address :'),
                              CustemTextFormField(
                                text: 'Your Address',
                                borderSideColor:
                                    AppColors.primaryBackgroundBlue,
                                controller: addressController,
                              ),
                            ],
                            const Gap(10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomLabelText(text: 'Password :'),
                                      const Gap(5),
                                      CustemTextFormField(
                                        text: 'Enter Password',
                                        borderSideColor:
                                            AppColors.primaryBackgroundBlue,
                                        obscureText: true,
                                        controller: passwordController,
                                      ),
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
                                          text: 'Confirm Password :'),
                                      const Gap(5),
                                      CustemTextFormField(
                                        text: 'Re-enter Password',
                                        borderSideColor:
                                            AppColors.primaryBackgroundBlue,
                                        obscureText: true,
                                        controller: confirmPasswordController,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Confirm password';
                                          }
                                          if (val != passwordController.text) {
                                            return 'Not match';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Gap(20),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRoute.loginScreen);
                              },
                              child: CustomText(
                                text: 'Already have account ?',
                                fontsize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryBackgroundBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
