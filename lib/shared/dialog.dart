import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String text,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).hintColor,

        content: Row(
          children: [
            CircularProgressIndicator(color: AppColors.primaryBackgroundBlue),
            SizedBox(width: 10),
            Text(text, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }

  static void hedLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void shoeMassage({
    required BuildContext context,
    required String massage,
    String? title,
    List<Widget>? actions,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).hintColor,
        content: Text(massage, style: Theme.of(context).textTheme.labelSmall),
        title: Text(
          title ?? " ",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        actions: actions,
      ),
    );
  }
}
