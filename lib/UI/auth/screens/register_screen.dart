import 'package:fix_hub/UI/auth/data/auth_repo.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/core/network/api_error.dart';
import 'package:fix_hub/provider/provider_user_type.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:fix_hub/shared/custom_dropDown.dart';
import 'package:fix_hub/shared/custom_label_text.dart';
import 'package:fix_hub/shared/custom_snackBar.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
  late ProviderUserType userType;
  AuthRepo authRepo = AuthRepo();

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
    userType = Provider.of<ProviderUserType>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  child: SizedBox(
                    width: AppMediaQuery.sizeWidth(context) - 10,
                    child: SingleChildScrollView(
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
                                borderSideColor:
                                    AppColors.primaryBackgroundBlue,
                                controller: numberController,
                                validator: (vale) {
                                  if (vale!.isEmpty) {
                                    return "Please Fill Enter Phone Number";
                                  }
                                  if (vale!.length < 11 || vale.length > 11) {
                                    return "The number you entered is incorrect";
                                  }
                                  return null;
                                }),
                            const Gap(10),
                            CustomLabelText(text: 'National ID :'),
                            CustemTextFormField(
                              keyboardType: TextInputType.number,
                              text: 'Your National ID',
                              borderSideColor: AppColors.primaryBackgroundBlue,
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
                            if (userType.userTypeProvider == 'Technical') ...[
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
                                          validator: (val) {
                                            if (val!.trim().isEmpty) {
                                              return "Please Fill Enter New Password";
                                            }
                                            final bool passwordValid = RegExp(
                                              r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#\$&*~]{8,}$',
                                            ).hasMatch(val);
                                            if (val.length < 8) {
                                              return "please Enter Password Greater 8 Number";
                                            }
                                            if (!passwordValid) {
                                              return "Please Enter Password Contains number uppercase or lowercase letter and symbols";
                                            }
                                            return null;
                                          }),
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
                                          if (val!.trim().isEmpty) {
                                            return "Please Fill Enter Confirmed Password";
                                          }
                                          if (val != passwordController.text) {
                                            return "Please Enter The Matching Password";
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
                SizedBox(
                  height: AppMediaQuery.sizeHeight(context) * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final user = await authRepo.register(
        isTechnical: userType.userTypeProvider == "Technical",
        name: nameController.text.trim(),
        phone: numberController.text.trim(),
        nationalId: nationalIdController.text.trim(),
        city: selectedCity ?? '',
        address: addressController.text.trim(),
        specialty: selectedSpecialty,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      if (user!.role == 'technical') {
        Navigator.pushReplacementNamed(context, AppRoute.craftManRootScreen);
      } else {
        Navigator.pushReplacementNamed(context, AppRoute.customerRootScreen);
      }
    } catch (e) {
      String errormsg = e is ApiError ? e.message : 'Error';

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errormsg));
    }

    setState(() => isLoading = false);
  }
}
