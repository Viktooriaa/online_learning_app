import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
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
                        size: 18,
                        color: titleColor,
                      ),
                    ),
                  ),
                  Text(
                    'My courses',
                    style: AppTextStyles.s18w600.copyWith(
                      color: titleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _LearnedTodayCard(
                isDark: isDark,
              ),
              const SizedBox(height: 20),
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
      height: 96,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.lightText,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Learned today',
            style: AppTextStyles.s12w400.copyWith(
              color: AppColors.greyText,
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '46min',
                  style: AppTextStyles.s20w700.copyWith(
                    color: isDark ? Colors.white : AppColors.darkText,
                    fontSize: 18,
                    height: 1,
                  ),
                ),
                TextSpan(
                  text: ' /60min',
                  style: AppTextStyles.s10w400.copyWith(
                    color: AppColors.greyText,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.progressBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 210,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0),
                      const Color(0xFFFF5106),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
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
        padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 23),
            Text(
              title,
              style: AppTextStyles.s16w500.copyWith(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
            SizedBox(height: progressTopSpacing),
            Container(
              width: 122,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 81,
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        actionColor.withValues(alpha: 0.35),
                        actionColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 9),
            Text(
              'Completed',
              style: AppTextStyles.s12w400.copyWith(
                color: textColor.withValues(alpha: 0.65),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  completed,
                  style: AppTextStyles.s20w700.copyWith(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: actionColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 26,
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
