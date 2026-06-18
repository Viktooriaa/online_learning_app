import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

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

      width: double.infinity,
      height: 56,

      child: ElevatedButton(

        onPressed: onPressed,

        style: ElevatedButton.styleFrom(

          backgroundColor: isDark
              ? AppColors.greyText
              : AppColors.lightBackground,

          elevation: 0,

          side: const BorderSide(
            color: AppColors.primary,
            width: 0.5,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
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