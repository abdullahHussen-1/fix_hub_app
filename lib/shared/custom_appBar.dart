import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key, required this.onTap, required this.text,this.onPress});
  final Function onTap;
  final Function?onPress;
  final String text;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.primaryBackgroundBlue, // لون أزرق مطابق للتصميم
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(AppAssets.logoIsWhite),
              InkWell(
                onTap: onTap(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryBackgroundWhite),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomText(
                      text: text,
                      fontsize: 10,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryBackgroundWhite),
                ),
              ),
              Gap(15),
              // أيقونة القائمة
              IconButton(
                color: AppColors.primaryBackgroundWhite,
                onPressed: onPress!(),
                icon: Icon(Icons.menu),
              ),
            ],
          )
        ],
      ),
    );
  }
}
