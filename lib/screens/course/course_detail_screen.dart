import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../payment/payment_card_screen.dart';
import '../main/no_videos_screen.dart';
import '../../core/utils/network_guard.dart';
import 'course_video_screen.dart';

enum _LessonAction { play, locked }

class _Lesson {
  const _Lesson({
    required this.number,
    required this.title,
    required this.duration,
    required this.action,
  });

  final int number;
  final String title;
  final String duration;
  final _LessonAction action;

  bool get isLocked => action == _LessonAction.locked;
}

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key, this.hasVideos = true});

  final bool hasVideos;

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _isBookmarked = false;

  static const _lessons = [
    _Lesson(
      number: 1,
      title: 'Welcome to the Course',
      duration: '6:10 mins',
      action: _LessonAction.play,
    ),
    _Lesson(
      number: 2,
      title: 'Process overview',
      duration: '6:10 mins',
      action: _LessonAction.play,
    ),
    _Lesson(
      number: 3,
      title: 'Discovery',
      duration: '6:10 mins',
      action: _LessonAction.locked,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;
    final heroBackground = const Color(0xFFFFE6EF);
    final cardBackground = isDark ? const Color(0xFF2F3048) : Colors.white;
    final textPrimary = isDark ? Colors.white : AppColors.darkText;
    final textMuted = isDark
        ? const Color(0xFFB8B8D2)
        : const Color(0xFF858597);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: cardBackground,
      ),
      child: Scaffold(
        backgroundColor: heroBackground,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final cardTop = topPadding + 252;
            final minCardHeight = constraints.maxHeight - cardTop;

            return Stack(
              children: [
                Positioned.fill(child: ColoredBox(color: heroBackground)),
                _DetailHero(topPadding: topPadding, isDark: isDark),
                Positioned(
                  left: 0,
                  right: 0,
                  top: cardTop,
                  bottom: 0,
                  child: _CourseContentCard(
                    minHeight: minCardHeight,
                    isDark: isDark,
                    backgroundColor: cardBackground,
                    textPrimary: textPrimary,
                    textMuted: textMuted,
                    isBookmarked: _isBookmarked,
                    onBookmarkTap: () =>
                        setState(() => _isBookmarked = !_isBookmarked),
                    lessons: _lessons,
                    hasVideos: widget.hasVideos,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DetailHero extends StatelessWidget {
  const _DetailHero({required this.topPadding, required this.isDark});

  final double topPadding;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: topPadding + 280,
      child: Stack(
        children: [
          Positioned(
            left: 22,
            top: topPadding + 18,
            child: GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: AppColors.darkText,
              ),
            ),
          ),
          Positioned(
            left: -25,
            right: -12,
            top: topPadding + 32,
            child: Image.asset(
              'assets/images/product_design_banner.png',
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseContentCard extends StatelessWidget {
  const _CourseContentCard({
    required this.minHeight,
    required this.isDark,
    required this.backgroundColor,
    required this.textPrimary,
    required this.textMuted,
    required this.isBookmarked,
    required this.onBookmarkTap,
    required this.lessons,
    required this.hasVideos,
  });

  final double minHeight;
  final bool isDark;
  final Color backgroundColor;
  final Color textPrimary;
  final Color textMuted;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;
  final List<_Lesson> lessons;
  final bool hasVideos;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: ColoredBox(
        color: backgroundColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                22,
                36,
                18,
                18 + MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CourseHeader(textPrimary: textPrimary, textMuted: textMuted),
                  const SizedBox(height: 24),
                  Text(
                    'About this course',
                    style: AppTextStyles.s14w500.copyWith(
                      color: textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Sed ut perspiciatis unde omnis iste natus error sit\nvoluptatem accusantium doloremque laudantium.',
                    style: AppTextStyles.s10w400.copyWith(
                      color: textMuted,
                      fontSize: 12.4,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: Icon(Icons.visibility_off_outlined,
                      color: isDark ? textMuted : AppColors.darkText,
                      size: isDark ? 24 : 16,
                    ),
                  ),
                  const SizedBox(height: 23),
                  ...lessons.map(
                    (lesson) => _LessonTile(
                      lesson: lesson,
                      isDark: isDark,
                      textPrimary: textPrimary,
                      textMuted: textMuted,
                      onPlayTap: () {
                        if (lesson.isLocked) return;

                        if (!hasVideos) {
                          NetworkGuard.push(
                            context,
                            () => const NoVideosScreen(),
                          );
                          return;
                        }

                        NetworkGuard.push(
                          context,
                          () => const CourseVideoScreen(),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height * 0.025).clamp(
                      14.0,
                      22.0,
                    ),
                  ),
                  _BottomActions(
                    isDark: isDark,
                    isBookmarked: isBookmarked,
                    onBookmarkTap: onBookmarkTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CourseHeader extends StatelessWidget {
  const _CourseHeader({required this.textPrimary, required this.textMuted});

  final Color textPrimary;
  final Color textMuted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Product Design v1.0',
                style: AppTextStyles.s16w500.copyWith(
                  color: textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ),
            Text(
              '\$74.00',
              style: AppTextStyles.s16w500.copyWith(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '6h 14min - 24 Lessons',
            style: AppTextStyles.s10w400.copyWith(
              color: textMuted,
              fontSize: 13,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _LessonTile extends StatelessWidget {
  const _LessonTile({
    required this.lesson,
    required this.isDark,
    required this.textPrimary,
    required this.textMuted,
    required this.onPlayTap,
  });

  final _Lesson lesson;
  final bool isDark;
  final Color textPrimary;
  final Color textMuted;
  final VoidCallback onPlayTap;

  @override
  Widget build(BuildContext context) {
    final lockBackground = isDark
        ? const Color(0xFF4A568E)
        : const Color(0xFFC8D1FF);

    return Padding(
      padding: const EdgeInsets.only(bottom: 23),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              lesson.number.toString().padLeft(2, '0'),
              style: AppTextStyles.s18w600.copyWith(
                color: const Color(0xFFB7B9D8),
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s12w500.copyWith(
                    color: textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      lesson.duration,
                      style: AppTextStyles.s10w400.copyWith(
                        color: lesson.title == 'Welcome to the Course'
                            ? AppColors.primary
                            : const Color(0xFFB8B8D2),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),

                    if (lesson.title == 'Welcome to the Course') ...[
                      const SizedBox(width: 4),

                      const Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 11,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          GestureDetector(
            onTap: lesson.isLocked ? null : onPlayTap,
            child: Container(
              width: 49,
              height: 49,
              decoration: BoxDecoration(
                color: lesson.isLocked ? lockBackground : AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                lesson.isLocked
                    ? Icons.lock_outline_rounded
                    : Icons.play_arrow_rounded,
                color: Colors.white,
                size: lesson.isLocked ? 23 : 31,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.isDark,
    required this.isBookmarked,
    required this.onBookmarkTap,
  });

  final bool isDark;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : Colors.white,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 24,
                  offset: const Offset(0, -8),
                ),
              ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBookmarkTap,
            child: Container(
              width: 92,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEDF1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isBookmarked ? Icons.star_rounded : Icons.star_border_rounded,
                color: const Color(0xFFFF6B35),
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  NetworkGuard.push(
                    context,
                    () => const PaymentCardScreen(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Buy Now',
                  style: AppTextStyles.s12w500.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
