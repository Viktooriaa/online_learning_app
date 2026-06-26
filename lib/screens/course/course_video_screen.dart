import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../payment/payment_card_screen.dart';
import '../main/no_videos_screen.dart';
import 'models/course_models.dart';
import 'providers/course_provider.dart';

part 'widgets/course_video_widgets.dart';

class CourseVideoScreen extends ConsumerWidget {
  const CourseVideoScreen({super.key, this.hasVideos = true});

  final bool hasVideos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!hasVideos) {
      return const NoVideosScreen();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;
    final videoBackground = AppColors.heroPink;
    final cardBackground = isDark ? AppColors.cardDarkElevated : Colors.white;
    final textPrimary = isDark ? Colors.white : AppColors.darkText;
    final textMuted = isDark ? AppColors.mutedText : AppColors.greyText;
    final isBookmarked = ref.watch(videoBookmarkProvider);
    final lessons = ref.watch(videoLessonsProvider);

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
                    isBookmarked: isBookmarked,
                    onBookmarkTap: () =>
                        ref.read(videoBookmarkProvider.notifier).toggle(),
                    lessons: lessons,
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
