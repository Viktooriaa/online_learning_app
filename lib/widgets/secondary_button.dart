import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_text_styles.dart';
import '../core/theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return SizedBox(

      width: double.infinity, height: 56.h,

      child: ElevatedButton(

        onPressed: onPressed,

        style: ElevatedButton.styleFrom(

          backgroundColor: isDark
              ? AppColors.greyText
              : AppColors.lightBackground,

          elevation: 0,

          side: BorderSide(
            color: AppColors.primary, width: 0.5.w,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),

        child: Text(
          text,

          style: AppTextStyles.s16w500.copyWith(
            color: isDark
                ? AppColors.lightText
                : AppColors.primary,
          ),
        ),
      ),
    );
  }
}