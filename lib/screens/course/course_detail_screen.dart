import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../payment/payment_card_screen.dart';
import '../main/no_videos_screen.dart';
import '../../core/utils/network_guard.dart';
import 'course_video_screen.dart';
import 'models/course_models.dart';
import 'providers/course_provider.dart';

part 'widgets/course_detail_widgets.dart';

class CourseDetailScreen extends ConsumerWidget {
  const CourseDetailScreen({super.key, this.hasVideos = true});

  final bool hasVideos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;
    final heroBackground = AppColors.heroPink;
    final cardBackground = isDark ? AppColors.cardDarkElevated : Colors.white;
    final textPrimary = isDark ? Colors.white : AppColors.darkText;
    final textMuted = isDark ? AppColors.mutedText : AppColors.greyText;
    final isBookmarked = ref.watch(courseBookmarkProvider);
    final lessons = ref.watch(detailLessonsProvider);

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
                    isBookmarked: isBookmarked,
                    onBookmarkTap: () => ref
                        .read(courseBookmarkProvider.notifier)
                        .toggle(),
                    lessons: lessons,
                    hasVideos: hasVideos,
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
