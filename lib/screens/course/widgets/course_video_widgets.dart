part of '../course_video_screen.dart';

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
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 17.w,
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
                width: 56.w, height: 56.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.75),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.pause_rounded,
                  color: Colors.white,
                  size: 30.w,
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
              size: 30.w,
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

        SizedBox(height: 4.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '4:28',
              style: AppTextStyles.s12w400.copyWith(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),

            Text(
              '6:10',
              style: AppTextStyles.s12w400.copyWith(
                color: Colors.white,
                fontSize: 12.sp,
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
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              // Помаранчева частина
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: trackHeight,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(10.r),
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
  final List<Lesson> lessons;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
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
                  SizedBox(height: 24.h),
                  Text(
                    AppStrings.aboutThisCourse,
                    style: AppTextStyles.s14w500.copyWith(
                      color: textPrimary,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700, height: 1,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    AppStrings.courseVideoDescription,
                    style: AppTextStyles.s10w400.copyWith(
                      color: textMuted,
                      fontSize: 12.4.sp, height: 1.45,
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Center(
                    child: Icon(
                      Icons.visibility_off_outlined,
                      color: isDark ? textMuted : AppColors.darkText,
                      size: isDark ? 24 : 16,
                    ),
                  ),
                  SizedBox(height: 23.h),
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
                AppStrings.productDesignV1,
                style: AppTextStyles.s16w500.copyWith(
                  color: textPrimary,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700, height: 1.1,
                ),
              ),
            ),
            Text(
              AppStrings.price74,
              style: AppTextStyles.s16w500.copyWith(
                color: AppColors.primary,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700, height: 1.1,
              ),
            ),
          ],
        ),
        SizedBox(height: 7.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppStrings.courseMeta,
            style: AppTextStyles.s10w400.copyWith(
              color: textMuted,
              fontSize: 13.sp, height: 1,
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

  final Lesson lesson;
  final bool isDark;
  final Color textPrimary;
  final Color textMuted;

  @override
  Widget build(BuildContext context) {
    final lockBackground = isDark
        ? AppColors.lessonLockDark
        : AppColors.lessonLockLight;

    return Padding(
      padding: EdgeInsets.only(bottom: 23.h),
      child: Row(
        children: [
          SizedBox(width: 40.w,
            child: Text(
              lesson.number.toString().padLeft(2, '0'),
              style: AppTextStyles.s18w600.copyWith(
                color: AppColors.lessonNumber,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500, height: 1,
              ),
            ),
          ),
          SizedBox(width: 22.w),
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
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500, height: 1,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      lesson.duration,
                      style: AppTextStyles.s10w400.copyWith(
                        color: lesson.title == AppStrings.welcomeToCourse
                            ? AppColors.orange
                            : AppColors.mutedText,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500, height: 1.2,
                      ),
                    ),

                    if (lesson.title == AppStrings.welcomeToCourse) ...[
                      SizedBox(width: 4.w),

                      Icon(
                        Icons.check_circle,
                        color: AppColors.orange,
                        size: 11.w,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 14.w),
          Stack(
            alignment: Alignment.center,
            children: [

              // Синє коло спочатку
              Container(
                width: 44.w, height: 44.h,
                decoration: BoxDecoration(
                  color: lesson.isLocked
                      ? lockBackground
                      : AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  lesson.action == LessonAction.locked
                      ? Icons.lock_outline_rounded
                      : lesson.action == LessonAction.pause
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: lesson.isLocked ? 18 : 25,
                ),
              ),

              // Потім дуга ПОВЕРХ
              if (lesson.action == LessonAction.pause)
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
                  blurRadius: 24.r,
                  offset: const Offset(0, -8),
                ),
              ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBookmarkTap,
            child: Container(
              width: 92.w, height: 52.h,
              decoration: BoxDecoration(
                color: AppColors.starBackground,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                isBookmarked ? Icons.star_rounded : Icons.star_border_rounded,
                color: AppColors.orangeDark,
                size: 30.w,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: SizedBox(height: 52.h,
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
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  AppStrings.buyNow,
                  style: AppTextStyles.s12w500.copyWith(
                    color: Colors.white,
                    fontSize: 18.sp,
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
