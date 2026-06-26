import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/course_models.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.isDark,
    required this.onTap,
  });

  final Course course;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 96.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.lightText,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 68.w,
              height: 68.h,
              decoration: BoxDecoration(
                color: AppColors.block,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: AppTextStyles.s14w500.copyWith(
                      color: isDark ? AppColors.lightText : AppColors.darkText,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 12.w,
                        color: AppColors.greyText,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        course.author,
                        style: AppTextStyles.s12w400.copyWith(
                          color: AppColors.border,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text(
                        course.price,
                        style: AppTextStyles.s16w500.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      isDark
                          ? Text(
                              course.hours,
                              style: AppTextStyles.s10w400.copyWith(
                                color: AppColors.orange,
                              ),
                            )
                          : Container(
                              width: 57.w,
                              height: 15.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.softWhite,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                course.hours,
                                style: AppTextStyles.s10w400.copyWith(
                                  color: AppColors.orange,
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
