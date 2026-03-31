import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_media_query.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:fix_hub/shared/custom_label_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AddrequestScreen extends StatefulWidget {
  const AddrequestScreen({super.key});
  @override
  State<AddrequestScreen> createState() => _AddrequestScreenState();
}

class _AddrequestScreenState extends State<AddrequestScreen> {
  final typeOfServiceController = TextEditingController();
  final problemDescriptionController = TextEditingController();
  final addphotosController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final addressController = TextEditingController();

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
                  text: 'Confirmation',
                )
                    .animate()
                    .fade(duration: 400.ms)
                    .slideY(begin: -0.5, curve: Curves.easeOut),
                const SizedBox(height: 20),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: AppMediaQuery.sizeWidth(context) - 40, //
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const CustomLabelText(text: 'Type of service'),
                          const SizedBox(height: 5),
                          CustemTextFormField(
                            controller: typeOfServiceController,
                            borderSideColor: AppColors.primaryBackgroundBlue,
                            suffixIcon: const Icon(Icons.arrow_drop_down,
                                color: AppColors.primaryBackgroundBlue,
                                size: 30),
                          ),
                          const SizedBox(height: 15),
                          const CustomLabelText(text: 'Problem description'),
                          const SizedBox(height: 5),
                          CustemTextFormField(
                            controller: problemDescriptionController,
                            borderSideColor: AppColors.primaryBackgroundBlue,
                            maxLines: 4,
                          ),
                          const SizedBox(height: 15),
                          const CustomLabelText(text: 'Add photos / videos'),
                          const SizedBox(height: 5),
                          CustemTextFormField(
                            controller: addphotosController,
                            borderSideColor: AppColors.primaryBackgroundBlue,
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.videocam,
                                    color: Color(0xFF2E3D4D), size: 28),
                                const SizedBox(width: 8),
                                const Icon(Icons.camera_alt,
                                    color: Color(0xFF2E3D4D), size: 24),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomLabelText(text: 'The date'),
                                    const SizedBox(height: 5),
                                    CustemTextFormField(
                                      controller: dateController,
                                      borderSideColor:
                                          AppColors.primaryBackgroundBlue,
                                      text: '2023-08-18',
                                      prefixIcon: const Icon(
                                          Icons.arrow_drop_down,
                                          color:
                                              AppColors.primaryBackgroundBlue),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomLabelText(text: 'The time'),
                                    const SizedBox(height: 5),
                                    CustemTextFormField(
                                      controller: timeController,
                                      borderSideColor:
                                          AppColors.primaryBackgroundBlue,
                                      text: '06:48 AM',
                                      prefixIcon: const Icon(
                                          Icons.arrow_drop_down,
                                          color:
                                              AppColors.primaryBackgroundBlue),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const CustomLabelText(text: 'The address'),
                          const SizedBox(height: 5),
                          CustemTextFormField(
                            controller: addressController,
                            borderSideColor: AppColors.primaryBackgroundBlue,
                            suffixIcon: const Icon(Icons.location_on,
                                color: Color(0xFF2E3D4D)),
                          ),
                          const SizedBox(height: 30),
                        ]
                            .animate(interval: 40.ms)
                            .fade(duration: 400.ms)
                            .slideX(begin: 0.05, curve: Curves.easeOut),
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
