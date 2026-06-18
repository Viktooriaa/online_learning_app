import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'course_detail_screen.dart';
import '../search/search_filter_sheet.dart';
import '../../core/utils/network_guard.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int selectedChip = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightText,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 20.h),

                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      'Course',

                      style: AppTextStyles.s24w700.copyWith(
                        color: isDark
                            ? AppColors.lightText
                            : AppColors.darkText,
                      ),
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),

                      child: Image.asset(
                        width: 36.w, height: 50.h,
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15.h),

                // SEARCH
                Container(
                  height: 50.h,

                  padding: EdgeInsets.symmetric(horizontal: 16.w),

                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.cardDark
                        : AppColors.findCourseBox,

                    borderRadius: BorderRadius.circular(14.r),
                  ),

                  child: Row(
                    children: [
                      Icon(Icons.search, color: AppColors.border),

                      SizedBox(width: 10.w),

                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Find Course',
                            hintStyle: AppTextStyles.s14w400.copyWith(
                              color: AppColors.border,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const SearchFilterSheet(),
                          );
                        },
                        child: Icon(Icons.tune, color: AppColors.border),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 4.h),

                // BANNERS
                Row(
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
                ),

                SizedBox(height: 36.h),

                Text(
                  'Choice your course',

                  style: AppTextStyles.s18w600.copyWith(
                    color: isDark ? AppColors.lightText : AppColors.darkText,
                  ),
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    _chip('All', 0),
                    SizedBox(width: 10.w),

                    _chip('Popular', 1),
                    SizedBox(width: 10.w),

                    _chip('New', 2),
                  ],
                ),

                SizedBox(height: 24.h),

                _courseCard(
                  isDark,
                  'Product Design v1.0',
                  'Robertson Connie',
                  '\$190',
                  '16 Hours',
                  onTap: () => _openCourseDetail(hasVideos: true),
                ),

                SizedBox(height: 14.h),

                _courseCard(
                  isDark,
                  'Product Design',
                  'Webb Landon',
                  '\$250',
                  '14 Hours',
                  onTap: () => _openCourseDetail(hasVideos: false),
                ),

                SizedBox(height: 14.h),

                _courseCard(
                  isDark,
                  'Product Design',
                  'Webb Kyle',
                  '\$250',
                  '14 Hours',
                  onTap: () => _openCourseDetail(hasVideos: true),
                ),

                SizedBox(height: 120.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openCourseDetail({required bool hasVideos}) {
    NetworkGuard.push(
      context,
      () => CourseDetailScreen(hasVideos: hasVideos),
    );
  }

  Widget _chip(String text, int index) {
    final selected = selectedChip == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedChip = index;
        });
      },
      child: Container(
        width: text == 'All' ? 73 : null, height: 28.h,

        alignment: Alignment.center,

        padding: EdgeInsets.symmetric(horizontal: 16.w),

        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.greyText,

          borderRadius: BorderRadius.circular(14.r),
        ),

        child: Text(
          text,
          style: AppTextStyles.s12w400.copyWith(
            color: selected ? AppColors.lightText : AppColors.lightText,
          ),
        ),
      ),
    );
  }

  Widget _courseCard(
    bool isDark,
    String title,
    String author,
    String price,
    String hours, {
    required VoidCallback onTap,
  }) {
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
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: 68.w, height: 68.h,
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
                    title,

                    style: AppTextStyles.s14w500.copyWith(
                      color: isDark ? AppColors.lightText : AppColors.darkText,
                    ),
                  ),

                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(Icons.person, size: 12.w, color: AppColors.greyText),
                      SizedBox(width: 4.w),
                      Text(
                        author,

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
                        price,

                        style: AppTextStyles.s16w500.copyWith(
                          color: AppColors.primary,
                        ),
                      ),

                      SizedBox(width: 6.w),

                      isDark
                          ? Text(
                              hours,
                              style: AppTextStyles.s10w400.copyWith(
                                color: AppColors.orange,
                              ),
                            )
                          : Container(
                              width: 57.w, height: 15.h,

                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                color: AppColors.softWhite,
                                borderRadius: BorderRadius.circular(20.r),
                              ),

                              child: Text(
                                hours,
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
