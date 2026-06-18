import 'package:flutter/material.dart';

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
            size: 17,
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
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
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

              const SizedBox(height: 14),

              // ── Category chips ─────────────────────────────────────────
              SizedBox(
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) => Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: chipColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _categories[index],
                      style: AppTextStyles.s12w400.copyWith(
                        color: isDark ? Colors.white : AppColors.greyText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Results label ──────────────────────────────────────────
              Text(
                'Results',
                style: AppTextStyles.s18w600.copyWith(
                  color: textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 5),

              // ── Course list ────────────────────────────────────────────
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _courses.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
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
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, size: 18, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Product Design',
              style: AppTextStyles.s14w400.copyWith(
                color: textColor,
                fontSize: 14,
              ),
            ),
          ),
          // X кнопка
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close_rounded,
              size: 13,
              color: isDark ? const Color(0xFF303049) : Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          // Filter icon
          GestureDetector(
            onTap: onFilterTap,
            child: Icon(Icons.tune_rounded, size: 20, color: iconColor),
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
        height: 96,
        padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isDark
              ? null
              : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFFC4C4C4)
                    : const Color(0xFFC4C4C4),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 12),

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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  // Author
                  Row(
                    children: [
                      Icon(Icons.person_outline_rounded,
                          size: 11, color: subtitleColor),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          course.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s12w400.copyWith(
                            color: subtitleColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Price + hours
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        course.price,
                        style: AppTextStyles.s16w500.copyWith(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Hours: pill у light mode, простий текст у dark
                      isDark
                          ? Text(
                        course.hours,
                        style: AppTextStyles.s10w400.copyWith(
                          color: AppColors.orange,
                          fontSize: 10,
                        ),
                      )
                          : Container(
                        height: 16,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF0E8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          course.hours,
                          style: AppTextStyles.s10w400.copyWith(
                            color: AppColors.orange,
                            fontSize: 9,
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