import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hintText;
  final void Function(String?)? onChanged;
  final Color borderColor;

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.borderColor =
        Colors.blue, // حط هنا لون الـ AppColors.primaryBackgroundBlue لو حابب
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      icon: Icon(Icons.arrow_drop_down, color: borderColor),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              30), 
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: borderColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      hint: Text(
        hintText,
        style: TextStyle(color: borderColor),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select a $hintText' : null,
    );
  }
}
