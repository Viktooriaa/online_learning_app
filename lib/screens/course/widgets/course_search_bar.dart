import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class CourseSearchBar extends StatelessWidget {
  const CourseSearchBar({
    super.key,
    required this.isDark,
    required this.onFilterTap,
  });

  final bool isDark;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.findCourseBox,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.border),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.findCourse,
                hintStyle: AppTextStyles.s14w400.copyWith(
                  color: AppColors.border,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: onFilterTap,
            child: const Icon(Icons.tune, color: AppColors.border),
          ),
        ],
      ),
    );
  }
}
