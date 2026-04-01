import 'package:fix_hub/UI/auth/data/auth_repo.dart';
import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/core/network/api_error.dart';
import 'package:fix_hub/shared/custem_elevated_button.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_label_text.dart';
import 'package:fix_hub/shared/custom_snackBar.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();

  @override
  void dispose() {
    phoneController.dispose();
    passController.dispose();
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
                const Gap(20),

                /// logo
                Center(
                  child: Image.asset(
                    AppAssets.logoIsBlue,
                    height: 120,
                  ),
                ),
                const Gap(30),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SizedBox(
                      width: AppMediaQuery.sizeWidth(context) - 40,
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabelText(text: 'Phone Number :'),
                            const Gap(10),
                            CustemTextFormField(
                              keyboardType: TextInputType.phone,
                              text: 'Enter Phone Number',
                              borderSideColor: AppColors.primaryBackgroundBlue,
                              controller: phoneController,
                            ),
                            const Gap(20),
                            CustomLabelText(text: 'Password :'),
                            const Gap(10),
                            CustemTextFormField(
                              text: 'Enter Password',
                              borderSideColor: AppColors.primaryBackgroundBlue,
                              obscureText: true,
                              controller: passController,
                            ),
                            const Gap(15),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoute.forgotPasswordScreen);
                                },
                                child: CustomText(
                                  text: 'Forget your password?',
                                  fontsize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Gap(30),
                            Center(
                              child: isLoading
                                  ? CupertinoActivityIndicator(
                                      color: AppColors.primaryBackgroundBlue)
                                  : CustemElevatedButton(
                                      heightContainer: 50,
                                      widthContainer: double.infinity,
                                      onPressed: () {
                                        login();
                                      },
                                      text: 'Login',
                                      backGroundColor: AppColors.blackColor,
                                      checkIcon: false,
                                    ),
                            ),
                            const Gap(10),
                            Center(
                              child: GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(
                                  context,
                                  AppRoute.registerScreen,
                                ),
                                child: CustomText(
                                  text: 'Sign Up',
                                  fontsize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.blackColor,
                                ),
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

  Future<void> login() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final user = await authRepo.login(
            phoneController.text.trim(), passController.text);

        if (user != null && user.role == 'Customer') {
          Navigator.pushReplacementNamed(context, AppRoute.customerRootScreen);
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
        String errormsg = 'Unhandled error in login';

        if (e is ApiError) {
          errormsg = e.message;
        }

        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errormsg));
      }
    }
  }
}
