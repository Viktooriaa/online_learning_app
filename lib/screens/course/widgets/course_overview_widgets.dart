import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../widgets/empty_state_view.dart';
import '../models/course_models.dart';
import 'course_card.dart';

class CourseHeader extends StatelessWidget {
  const CourseHeader({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.course,
          style: AppTextStyles.s24w700.copyWith(
            color: isDark ? AppColors.lightText : AppColors.darkText,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: Image.asset(
            'assets/images/avatar.png',
            width: 36.w,
            height: 50.h,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class CourseCategoryBanners extends StatelessWidget {
  const CourseCategoryBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              'assets/images/language.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              'assets/images/painting.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class CourseList extends StatelessWidget {
  const CourseList({
    super.key,
    required this.courses,
    required this.isDark,
    required this.onCourseTap,
  });

  final List<Course> courses;
  final bool isDark;
  final ValueChanged<Course> onCourseTap;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const EmptyStateBody(
        kind: EmptyStateKind.products,
        title: AppStrings.noProductsTitle,
        subtitle: AppStrings.noProductsSubtitle,
        yOffset: -16,
      );
    }

    return Column(
      children: [
        for (final course in courses) ...[
          CourseCard(
            course: course,
            isDark: isDark,
            onTap: () => onCourseTap(course),
          ),
          SizedBox(height: 14.h),
        ],
      ],
    );
  }
}
