import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:online_learning_app/screens/main/home_screen.dart';
import 'package:online_learning_app/screens/main/main_screen.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/network_guard.dart';
import '../main/my_courses_screen.dart';

class WeeklyProgressScreen extends StatelessWidget {
  const WeeklyProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? AppColors.darkBackground
        : const Color(0xFF58586E);
    final cardColor = isDark ? const Color(0xFF303049) : Colors.white;
    final textPrimary = isDark ? Colors.white : AppColors.darkText;
    final textMuted = isDark ? const Color(0xFFB8B8D2) : AppColors.greyText;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: background,
      ),
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ProgressCard(
                    cardColor: cardColor,
                    textPrimary: textPrimary,
                    textMuted: textMuted,
                    isDark: isDark,
                    onShare: () {
                      NetworkGuard.push(
                        context,
                        () => const MyCoursesScreen(),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MainScreen(),
                      ),
                    ),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
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

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.cardColor,
    required this.textPrimary,
    required this.textMuted,
    required this.isDark,
    required this.onShare,
  });

  final Color cardColor;
  final Color textPrimary;
  final Color textMuted;
  final bool isDark;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 291,
      height: 442,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Clocking in!',
              style: AppTextStyles.s24w700.copyWith(
                color: textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              isDark ? 'GOOD JOB!' : 'GOOD JOB',
              style: AppTextStyles.s14w400.copyWith(
                color: textMuted,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 39),
            Row(
              children: [
                Expanded(
                  child: _Metric(
                    label: 'Learned today',
                    value: '46',
                    suffix: 'min',
                    textPrimary: textPrimary,
                    textMuted: textMuted,
                  ),
                ),
                Expanded(
                  child: _Metric(
                    label: 'total hours',
                    value: '468',
                    suffix: 'hrs',
                    textPrimary: textPrimary,
                    textMuted: textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 23),
            _Metric(
              label: 'Today days',
              value: '554',
              suffix: 'days',
              textPrimary: textPrimary,
              textMuted: textMuted,
            ),
            const SizedBox(height: 33),
            Center(
              child: Text(
                'Record of this week',
                style: AppTextStyles.s12w400.copyWith(
                  color: textMuted,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                7,
                (index) => Container(
                  width: 28,
                  height: 28,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: index < 4
                        ? AppColors.primary
                        : (isDark
                              ? const Color(0xFFE2E2F0)
                              : const Color(0xFFE2E2F0)),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: AppTextStyles.s12w400.copyWith(
                      color: index < 4 ? Colors.white : AppColors.greyText,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 38),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onShare,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Share',
                  style: AppTextStyles.s16w500.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    required this.suffix,
    required this.textPrimary,
    required this.textMuted,
  });

  final String label;
  final String value;
  final String suffix;
  final Color textPrimary;
  final Color textMuted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.s12w400.copyWith(color: textMuted, fontSize: 12),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            style: AppTextStyles.s20w700.copyWith(
              color: textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(text: value),
              TextSpan(
                text: ' $suffix',
                style: AppTextStyles.s12w400.copyWith(
                  color: textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
