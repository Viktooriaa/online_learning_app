import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/state/app_state.dart';
import '../../core/utils/network_guard.dart';
import '../course/course_video_screen.dart';
import 'no_products_screen.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppState.purchaseCompleted,
      builder: (context, purchased, _) {
        if (!purchased) {
          return const NoProductsScreen();
        }

        return _MyCoursesContent();
      },
    );
  }
}

class _MyCoursesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.darkBackground : Colors.white;
    final titleColor = isDark ? Colors.white : AppColors.darkText;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18.w,
                        color: titleColor,
                      ),
                    ),
                  ),
                  Text(
                    'My courses',
                    style: AppTextStyles.s18w600.copyWith(
                      color: titleColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              _LearnedTodayCard(
                isDark: isDark,
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: GridView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 160 / 182,
                  ),
                  children: [
                    _CourseProgressCard(
                      isDark: isDark,
                      title: 'Product\nDesign v1.0',
                      completed: '14/24',
                      color: const Color(0xFFFFE7EE),
                      actionColor: const Color(0xFFEC7B9C),
                      onTap: () => _openVideo(context),
                    ),
                    _CourseProgressCard(
                      isDark: isDark,
                      title: 'Java\nDevelopment',
                      completed: '12/18',
                      color: const Color(0xFFBAD6FF),
                      actionColor: AppColors.primary,
                      onTap: () => _openVideo(context),
                    ),
                    _CourseProgressCard(
                      isDark: isDark,
                      title: 'Visual Design',
                      completed: '10/16',
                      color: const Color(0xFFBAE0DB),
                      actionColor: const Color(0xFF398A80),
                      progressTopSpacing: 46,
                      onTap: () => _openVideo(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openVideo(BuildContext context) {
    NetworkGuard.push(
      context,
      () => const CourseVideoScreen(),
    );
  }
}

class _LearnedTodayCard extends StatelessWidget {
  const _LearnedTodayCard({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.lightText,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            'Learned today',
            style: AppTextStyles.s12w400.copyWith(
              color: AppColors.greyText,
            ),
          ),
          SizedBox(height: 5.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '46min',
                  style: AppTextStyles.s20w700.copyWith(
                    color: isDark ? Colors.white : AppColors.darkText,
                    fontSize: 18.sp, height: 1,
                  ),
                ),
                TextSpan(
                  text: ' /60min',
                  style: AppTextStyles.s10w400.copyWith(
                    color: AppColors.greyText,
                    fontSize: 8.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          Container(
            width: double.infinity, height: 6.h,
            decoration: BoxDecoration(
              color: AppColors.progressBackground,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 210.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0),
                      const Color(0xFFFF5106),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseProgressCard extends StatelessWidget {
  const _CourseProgressCard({
    required this.isDark,
    required this.title,
    required this.completed,
    required this.color,
    required this.actionColor,
    required this.onTap,
    this.progressTopSpacing = 23,
  });

  final bool isDark;
  final String title;
  final String completed;
  final Color color;
  final Color actionColor;
  final VoidCallback onTap;
  final double progressTopSpacing;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppColors.darkText : AppColors.darkText;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(14.w, 18.h, 14.w, 14.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 23.h),
            Text(
              title,
              style: AppTextStyles.s16w500.copyWith(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700, height: 1.25,
              ),
            ),
            SizedBox(height: progressTopSpacing),
            Container(
              width: 122.w, height: 6.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 81.w, height: 6.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        actionColor.withValues(alpha: 0.35),
                        actionColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 9.h),
            Text(
              'Completed',
              style: AppTextStyles.s12w400.copyWith(
                color: textColor.withValues(alpha: 0.65),
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Text(
                  completed,
                  style: AppTextStyles.s20w700.copyWith(
                    color: textColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 44.w, height: 44.h,
                  decoration: BoxDecoration(
                    color: actionColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 26.w,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
