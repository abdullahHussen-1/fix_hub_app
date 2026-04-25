import 'package:fix_hub/UI/home/data/models/craftsmans_model.dart';
import 'package:fix_hub/UI/tasks/data/task_model.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';
import 'package:fix_hub/shared/custem_text_form_field.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:fix_hub/shared/custom_label_text.dart';
import 'package:fix_hub/shared/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart'; // تأكد من إضافة intl في pubspec.yaml

class AddrequestScreen extends StatefulWidget {
  const AddrequestScreen({super.key});

  @override
  State<AddrequestScreen> createState() => _AddrequestScreenState();
}

class _AddrequestScreenState extends State<AddrequestScreen> {
  final typeOfServiceController = TextEditingController();
  final problemDescriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final addressController = TextEditingController();

  // دالة اختيار التاريخ
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // دالة اختيار الوقت
  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tech = ModalRoute.of(context)!.settings.arguments as Technician;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundWhite,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // داخل CustomAppbar في صفحة AddrequestScreen
                CustomAppbar(
                  onTap: () async {
                    if (problemDescriptionController.text.isEmpty ||
                        dateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar("Please fill all fields"));
                      return;
                    }
                    final userId = await PrefHelper.getCurrentUserId();
                    final task = TaskModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        technicianId: tech.id,
                        userName: await PrefHelper.getUserName() ?? "Client",
                        userImage: "",
                        typeOfService: tech.specialty,
                        description: problemDescriptionController.text,
                        date: dateController.text,
                        time: timeController.text,
                        address: addressController.text,
                        userId: userId ?? "null");

                    await PrefHelper.saveTask(task);
                    print(userId ?? "null");
                    // إظهار الرسالة بنجاح
                    ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                        "Request sent to ${tech.name} successfully!"));

                    Navigator.pop(context);
                  },
                  text: 'Confirm Request',
                ).animate().fade().slideY(begin: -0.5),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomLabelText(text: 'Problem description'),
                        const SizedBox(height: 5),
                        CustemTextFormField(
                          controller: problemDescriptionController,
                          borderSideColor: AppColors.primaryBackgroundBlue,
                          text: "Describe the issue...",
                          maxLines: 3,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(text: 'Date'),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: _selectDate,
                                    child: AbsorbPointer(
                                      child: CustemTextFormField(
                                        controller: dateController,
                                        text: 'Select Date',
                                        prefixIcon: const Icon(
                                            Icons.calendar_month,
                                            color: AppColors
                                                .primaryBackgroundBlue),
                                        borderSideColor:
                                            AppColors.primaryBackgroundBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(text: 'Time'),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: _selectTime,
                                    child: AbsorbPointer(
                                      child: CustemTextFormField(
                                        controller: timeController,
                                        text: 'Select Time',
                                        prefixIcon: const Icon(
                                            Icons.access_time_filled,
                                            color: AppColors
                                                .primaryBackgroundBlue),
                                        borderSideColor:
                                            AppColors.primaryBackgroundBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const CustomLabelText(text: 'Work Address'),
                        const SizedBox(height: 5),
                        CustemTextFormField(
                          controller: addressController,
                          borderSideColor: AppColors.primaryBackgroundBlue,
                          text: "Street, City...",
                          suffixIcon: const Icon(Icons.location_on,
                              color: AppColors.primaryBackgroundBlue),
                        ),
                      ],
                    ).animate().fade().slideX(begin: 0.1),
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
