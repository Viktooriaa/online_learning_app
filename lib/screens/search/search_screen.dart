import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../course/course_detail_screen.dart';
import 'search_filter_sheet.dart';
import '../../core/utils/network_guard.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const _categories = [
    'Visual Identity',
    'Painting',
    'Coding',
    'Writing',
    'Coding',
  ];

  static const _courses = [
    _SearchCourse(
      title: 'Product Design v1.0',
      author: 'Robertson Connie',
      price: '\$190',
      hours: '16 hours',
    ),
    _SearchCourse(
      title: 'Product Design',
      author: 'Webb Landon',
      price: '\$250',
      hours: '14 hours',
    ),
    _SearchCourse(
      title: 'Product Design',
      author: 'Webb Kyle',
      price: '\$250',
      hours: '14 hours',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color background  = isDark ? AppColors.darkBackground : Colors.white;
    final Color textPrimary = isDark ? Colors.white : AppColors.darkText;
    final Color fieldColor  = isDark ? const Color(0xFF303049) : const Color(0xFFF4F3FD);
    final Color chipColor   = isDark ? const Color(0xFF57576D) : const Color(0xFFF4F3FD);
    final Color cardColor   = isDark ? const Color(0xFF2F3048) : Colors.white;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 17.w,
            color: textPrimary,
          ),
        ),
        // Заголовок "Search" тільки в dark mode
        title: Text(
          'Search',
          style: AppTextStyles.s18w600.copyWith(
            color: isDark
                ? Colors.white
                : AppColors.darkText,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Search field ───────────────────────────────────────────
              _SearchField(
                color: fieldColor,
                isDark: isDark,
                onFilterTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const SearchFilterSheet(),
                  );
                },
              ),

              SizedBox(height: 14.h),

              // ── Category chips ─────────────────────────────────────────
              SizedBox(height: 30.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _categories.length,
                  separatorBuilder: (_, _) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) => Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: chipColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _categories[index],
                      style: AppTextStyles.s12w400.copyWith(
                        color: isDark ? Colors.white : AppColors.greyText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // ── Results label ──────────────────────────────────────────
              Text(
                'Results',
                style: AppTextStyles.s18w600.copyWith(
                  color: textPrimary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 5.h),

              // ── Course list ────────────────────────────────────────────
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _courses.length,
                  separatorBuilder: (_, _) => SizedBox(height: 14.h),
                  itemBuilder: (context, index) => _CourseResultCard(
                    course: _courses[index],
                    isDark: isDark,
                    backgroundColor: cardColor,
                    onTap: () => NetworkGuard.push(
                      context,
                      () => CourseDetailScreen(
                        hasVideos: index.isEven,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Search field ──────────────────────────────────────────────────────────────
class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.color,
    required this.isDark,
    required this.onFilterTap,
  });

  final Color        color;
  final bool         isDark;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
    isDark ? const Color(0xFF8B8BA8) : const Color(0xFFB8B8D2);
    final Color textColor =
    isDark ? Colors.white : AppColors.darkText;

    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, size: 18.w, color: iconColor),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Product Design',
              style: AppTextStyles.s14w400.copyWith(
                color: textColor,
                fontSize: 14.sp,
              ),
            ),
          ),
          // X кнопка
          Container(
            width: 16.w, height: 16.h,
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close_rounded,
              size: 13.w,
              color: isDark ? const Color(0xFF303049) : Colors.white,
            ),
          ),
          SizedBox(width: 12.w),
          // Filter icon
          GestureDetector(
            onTap: onFilterTap,
            child: Icon(Icons.tune_rounded, size: 20.w, color: iconColor),
          ),
        ],
      ),
    );
  }
}

// ── Course result card ────────────────────────────────────────────────────────
class _CourseResultCard extends StatelessWidget {
  const _CourseResultCard({
    required this.course,
    required this.isDark,
    required this.backgroundColor,
    required this.onTap,
  });

  final _SearchCourse course;
  final bool          isDark;
  final Color         backgroundColor;
  final VoidCallback  onTap;

  @override
  Widget build(BuildContext context) {
    final Color subtitleColor =
    isDark ? const Color(0xFFB8B8D2) : AppColors.greyText;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 96.h,
        padding: EdgeInsets.fromLTRB(8.w, 8.h, 12.w, 8.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isDark
              ? null
              : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 20.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 68.w, height: 68.h,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFFC4C4C4)
                    : const Color(0xFFC4C4C4),
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            SizedBox(width: 12.w),

            // Info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    course.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s14w500.copyWith(
                      color: isDark ? Colors.white : AppColors.darkText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  // Author
                  Row(
                    children: [
                      Icon(Icons.person_outline_rounded,
                          size: 11.w, color: subtitleColor),
                      SizedBox(width: 3.w),
                      Flexible(
                        child: Text(
                          course.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s12w400.copyWith(
                            color: subtitleColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  // Price + hours
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        course.price,
                        style: AppTextStyles.s16w500.copyWith(
                          color: AppColors.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      // Hours: pill у light mode, простий текст у dark
                      isDark
                          ? Text(
                        course.hours,
                        style: AppTextStyles.s10w400.copyWith(
                          color: AppColors.orange,
                          fontSize: 10.sp,
                        ),
                      )
                          : Container(
                        height: 16.h,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF0E8),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          course.hours,
                          style: AppTextStyles.s10w400.copyWith(
                            color: AppColors.orange,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
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

// ── Модель ────────────────────────────────────────────────────────────────────
class _SearchCourse {
  const _SearchCourse({
    required this.title,
    required this.author,
    required this.price,
    required this.hours,
  });

  final String title;
  final String author;
  final String price;
  final String hours;
}