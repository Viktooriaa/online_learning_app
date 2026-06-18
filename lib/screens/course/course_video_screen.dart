import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../payment/payment_card_screen.dart';
import '../main/no_videos_screen.dart';

enum _LessonAction { play, pause, locked }

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

class CourseVideoScreen extends StatefulWidget {
  const CourseVideoScreen({super.key, this.hasVideos = true});

  final bool hasVideos;

  @override
  State<CourseVideoScreen> createState() => _CourseVideoScreenState();
}

class _CourseVideoScreenState extends State<CourseVideoScreen> {
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
      action: _LessonAction.pause,
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
    if (!widget.hasVideos) {
      return const NoVideosScreen();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;
    final videoBackground = const Color(0xFFFFE6EF);
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
        backgroundColor: videoBackground,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final cardTop = topPadding + 252;
            final minCardHeight = constraints.maxHeight - cardTop;

            return Stack(
              children: [
                Positioned.fill(child: ColoredBox(color: videoBackground)),
                _VideoHero(topPadding: topPadding, isDark: isDark),
                Positioned(
                  left: 0,
                  right: 0,
                  top: cardTop,
                  bottom: 0,
                  child: _VideoCourseCard(
                    minHeight: minCardHeight,
                    isDark: isDark,
                    backgroundColor: cardBackground,
                    textPrimary: textPrimary,
                    textMuted: textMuted,
                    isBookmarked: _isBookmarked,
                    onBookmarkTap: () =>
                        setState(() => _isBookmarked = !_isBookmarked),
                    lessons: _lessons,
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

class _VideoHero extends StatelessWidget {
  const _VideoHero({required this.topPadding, required this.isDark});

  final double topPadding;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: topPadding + 276,
      child: Stack(
        children: [
          Positioned(
            left: -30,
            right: 130,
            top: topPadding + 20,
            bottom: 35,
            child: Image.asset(
              'assets/images/course_video_screen.png',
              fit: BoxFit.fitHeight,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned.fill(
            child: ColoredBox(
              color: AppColors.darkText.withValues(alpha: isDark ? 0.50 : 0.50),
            ),
          ),
          Positioned(
            left: 22,
            top: topPadding + 18,
            child: GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 17,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: topPadding + 78,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.75),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.pause_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned(
            right: 12,
            top: topPadding + 185,
            child: Icon(
              Icons.fullscreen_rounded,
              color: Colors.white.withValues(alpha: 0.9),
              size: 30,
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            top: topPadding + 215,
            child: const _VideoTimeline(),
          ),
        ],
      ),
    );
  }
}

class _VideoTimeline extends StatelessWidget {
  const _VideoTimeline();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const _ProgressTrack(),

        const SizedBox(height: 4),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '4:28',
              style: AppTextStyles.s12w400.copyWith(
                color: Colors.white,
                fontSize: 12,
              ),
            ),

            Text(
              '6:10',
              style: AppTextStyles.s12w400.copyWith(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProgressTrack extends StatelessWidget {
  const _ProgressTrack();

  @override
  Widget build(BuildContext context) {
    const progress = 0.72;

    const trackHeight = 2.0;

    const knobSize = 14.0;
    const innerDotSize = 6.0;

    return SizedBox(
      height: knobSize,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final knobLeft =
          (constraints.maxWidth * progress - knobSize / 2)
              .clamp(
            0.0,
            constraints.maxWidth - knobSize,
          )
              .toDouble();

          return Stack(
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.none,
            children: [

              // Біла лінія
              Container(
                height: trackHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Помаранчева частина
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: trackHeight,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Повзунок
              Positioned(
                left: knobLeft,
                child: Container(
                  width: knobSize,
                  height: knobSize,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: innerDotSize,
                      height: innerDotSize,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _VideoCourseCard extends StatelessWidget {
  const _VideoCourseCard({
    required this.minHeight,
    required this.isDark,
    required this.backgroundColor,
    required this.textPrimary,
    required this.textMuted,
    required this.isBookmarked,
    required this.onBookmarkTap,
    required this.lessons,
  });

  final double minHeight;
  final bool isDark;
  final Color backgroundColor;
  final Color textPrimary;
  final Color textMuted;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;
  final List<_Lesson> lessons;

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
                  _CompactHeader(
                    textPrimary: textPrimary,
                    textMuted: textMuted,
                  ),
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
                    'Sed ut perspiciatis unde omnis iste natus error sit \nvoluptatem accusantium doloremque laudantium.',
                    style: AppTextStyles.s10w400.copyWith(
                      color: textMuted,
                      fontSize: 12.4,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 13),
                  Center(
                    child: Icon(
                      Icons.visibility_off_outlined,
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

class _CompactHeader extends StatelessWidget {
  const _CompactHeader({required this.textPrimary, required this.textMuted});

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
  });

  final _Lesson lesson;
  final bool isDark;
  final Color textPrimary;
  final Color textMuted;

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
                            ? AppColors.orange
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
                        color: AppColors.orange,
                        size: 11,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Stack(
            alignment: Alignment.center,
            children: [

              // Синє коло спочатку
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: lesson.isLocked
                      ? lockBackground
                      : AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  lesson.action == _LessonAction.locked
                      ? Icons.lock_outline_rounded
                      : lesson.action == _LessonAction.pause
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: lesson.isLocked ? 18 : 25,
                ),
              ),

              // Потім дуга ПОВЕРХ
              if (lesson.action == _LessonAction.pause)
                Positioned.fill(
                  child: CustomPaint(
                    painter: PauseAccentPainter(),
                  ),
                ),
            ],
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PaymentCardScreen(),
                    ),
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

class PauseAccentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(
      1.5,
      1.5,
      size.width - 3,
      size.height - 3,
    );

    canvas.drawArc(
      rect,
      -1.55, // старт зверху
      4,   // майже повне коло
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
