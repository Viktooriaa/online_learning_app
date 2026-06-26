import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class CourseFilterChip extends StatelessWidget {
  const CourseFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: label == AppStrings.all ? 73 : null,
        height: 28.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.greyText,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.s12w400.copyWith(
            color: AppColors.lightText,
          ),
        ),
      ),
    );
  }
}
