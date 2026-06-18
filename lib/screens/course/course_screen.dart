import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'course_detail_screen.dart';
import '../search/search_filter_sheet.dart';
import '../../core/utils/network_guard.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int selectedChip = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightText,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 20),

                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      'Course',

                      style: AppTextStyles.s24w700.copyWith(
                        color: isDark
                            ? AppColors.lightText
                            : AppColors.darkText,
                      ),
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),

                      child: Image.asset(
                        width: 36,
                        height: 50,
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // SEARCH
                Container(
                  height: 50,

                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.cardDark
                        : AppColors.findCourseBox,

                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Row(
                    children: [
                      Icon(Icons.search, color: AppColors.border),

                      const SizedBox(width: 10),

                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Find Course',
                            hintStyle: AppTextStyles.s14w400.copyWith(
                              color: AppColors.border,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const SearchFilterSheet(),
                          );
                        },
                        child: Icon(Icons.tune, color: AppColors.border),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                // BANNERS
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),

                        child: Image.asset(
                          'assets/images/language.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),

                        child: Image.asset(
                          'assets/images/painting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 36),

                Text(
                  'Choice your course',

                  style: AppTextStyles.s18w600.copyWith(
                    color: isDark ? AppColors.lightText : AppColors.darkText,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    _chip('All', 0),
                    const SizedBox(width: 10),

                    _chip('Popular', 1),
                    const SizedBox(width: 10),

                    _chip('New', 2),
                  ],
                ),

                const SizedBox(height: 24),

                _courseCard(
                  isDark,
                  'Product Design v1.0',
                  'Robertson Connie',
                  '\$190',
                  '16 Hours',
                  onTap: () => _openCourseDetail(hasVideos: true),
                ),

                const SizedBox(height: 14),

                _courseCard(
                  isDark,
                  'Product Design',
                  'Webb Landon',
                  '\$250',
                  '14 Hours',
                  onTap: () => _openCourseDetail(hasVideos: false),
                ),

                const SizedBox(height: 14),

                _courseCard(
                  isDark,
                  'Product Design',
                  'Webb Kyle',
                  '\$250',
                  '14 Hours',
                  onTap: () => _openCourseDetail(hasVideos: true),
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openCourseDetail({required bool hasVideos}) {
    NetworkGuard.push(
      context,
      () => CourseDetailScreen(hasVideos: hasVideos),
    );
  }

  Widget _chip(String text, int index) {
    final selected = selectedChip == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedChip = index;
        });
      },
      child: Container(
        width: text == 'All' ? 73 : null,
        height: 28,

        alignment: Alignment.center,

        padding: const EdgeInsets.symmetric(horizontal: 16),

        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.greyText,

          borderRadius: BorderRadius.circular(14),
        ),

        child: Text(
          text,
          style: AppTextStyles.s12w400.copyWith(
            color: selected ? AppColors.lightText : AppColors.lightText,
          ),
        ),
      ),
    );
  }

  Widget _courseCard(
    bool isDark,
    String title,
    String author,
    String price,
    String hours, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 96,

        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.lightText,

          borderRadius: BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: AppColors.block,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: AppTextStyles.s14w500.copyWith(
                      color: isDark ? AppColors.lightText : AppColors.darkText,
                    ),
                  ),

                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.person, size: 12, color: AppColors.greyText),
                      const SizedBox(width: 4),
                      Text(
                        author,

                        style: AppTextStyles.s12w400.copyWith(
                          color: AppColors.border,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Text(
                        price,

                        style: AppTextStyles.s16w500.copyWith(
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(width: 6),

                      isDark
                          ? Text(
                              hours,
                              style: AppTextStyles.s10w400.copyWith(
                                color: AppColors.orange,
                              ),
                            )
                          : Container(
                              width: 57,
                              height: 15,

                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                color: AppColors.softWhite,
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Text(
                                hours,
                                style: AppTextStyles.s10w400.copyWith(
                                  color: AppColors.orange,
                                  fontSize: 8,
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
