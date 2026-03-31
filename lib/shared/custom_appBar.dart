import 'package:fix_hub/core/constants/app_assets.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomAppbar extends StatelessWidget {
  final VoidCallback? onTap; 
  final String? text; 

  const CustomAppbar({
    super.key,
    this.onTap, 
    this.text, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.primaryBackgroundBlue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppAssets.logoIsWhite,
            width: 70,
            height: 30,
            fit: BoxFit.contain,
          ),
          Row(
            children: [
              if (text != null && text!.isNotEmpty) ...[
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.primaryBackgroundWhite, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: CustomText(
                        text: text!,
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBackgroundWhite,
                      ),
                    ),
                  ),
                ),
                Gap(15),
              ],
               IconButton(
                onPressed:(){} ,
               icon: Icon(Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 20,)
              ),
            ],
          )
        ],
      ),
    );
  }
}
