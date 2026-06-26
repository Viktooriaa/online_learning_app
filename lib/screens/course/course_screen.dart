import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/network_guard.dart';
import '../search/search_filter_sheet.dart';
import 'course_detail_screen.dart';
import 'providers/course_provider.dart';
import 'widgets/course_filter_chip.dart';
import 'widgets/course_overview_widgets.dart';
import 'widgets/course_search_bar.dart';

class CourseScreen extends ConsumerWidget {
  const CourseScreen({super.key});

  static const _filters = [
    AppStrings.all,
    AppStrings.popular,
    AppStrings.newest,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedChip = ref.watch(courseCategoryProvider);
    final courses = ref.watch(coursesProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightText,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                CourseHeader(isDark: isDark),
                SizedBox(height: 15.h),
                CourseSearchBar(
                  isDark: isDark,
                  onFilterTap: () => _showFilterSheet(context),
                ),
                SizedBox(height: 4.h),
                const CourseCategoryBanners(),
                SizedBox(height: 36.h),
                Text(
                  AppStrings.choiceYourCourse,
                  style: AppTextStyles.s18w600.copyWith(
                    color: isDark ? AppColors.lightText : AppColors.darkText,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    for (var index = 0; index < _filters.length; index++) ...[
                      CourseFilterChip(
                        label: _filters[index],
                        isSelected: selectedChip == index,
                        onTap: () => ref
                            .read(courseCategoryProvider.notifier)
                            .select(index),
                      ),
                      if (index != _filters.length - 1) SizedBox(width: 10.w),
                    ],
                  ],
                ),
                SizedBox(height: 24.h),
                CourseList(
                  courses: courses,
                  isDark: isDark,
                  onCourseTap: (course) => _openCourseDetail(
                    context,
                    hasVideos: course.hasVideos,
                  ),
                ),
                SizedBox(height: 120.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => const SearchFilterSheet(),
    );
  }

  void _openCourseDetail(BuildContext context, {required bool hasVideos}) {
    NetworkGuard.push(
      context,
      () => CourseDetailScreen(hasVideos: hasVideos),
    );
  }
}
