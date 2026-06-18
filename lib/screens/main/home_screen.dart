import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/network_guard.dart';
import 'my_courses_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightText,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              SizedBox(
                height: 220,

                child: Stack(
                  clipBehavior: Clip.none,

                  children: [
                    Container(
                      width: double.infinity,
                      height: 170,

                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 16,
                      ),

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withValues(alpha: 0.85),
                          ],

                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const SizedBox(height: 10),

                              Text(
                                'Hi, Kristin',

                                style: AppTextStyles.s24w700.copyWith(
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "Let's start learning",

                                style: AppTextStyles.s14w400.copyWith(
                                  color: Colors.white.withValues(alpha: 0.75),
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),
                          ClipRRect(
                            child: Image.asset('assets/images/avatar.png'),
                          ),
                        ],
                      ),
                    ),

                    // STATS CARD
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 0,

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),

                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : Colors.white,

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
                            Row(
                              children: [
                                Text(
                                  'Learned today',

                                  style: AppTextStyles.s12w400.copyWith(
                                    color: AppColors.greyText,
                                  ),
                                ),

                                const Spacer(),

                                GestureDetector(
                                  onTap: () => NetworkGuard.push(
                                    context,
                                    () => const MyCoursesScreen(),
                                  ),
                                  child: Text(
                                    'My courses',
                                    style: AppTextStyles.s12w400.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '46min',

                                    style: AppTextStyles.s20w700.copyWith(
                                      color: isDark
                                          ? AppColors.lightText
                                          : AppColors.darkText,
                                    ),
                                  ),

                                  TextSpan(
                                    text: ' / 60min',
                                    style: AppTextStyles.s10w400.copyWith(
                                      color: AppColors.greyText,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            Container(

                              width: double.infinity,
                              height: 5,

                              decoration: BoxDecoration(

                                color: AppColors.progressBackground,

                                borderRadius:
                                BorderRadius.circular(20),
                              ),

                              child: Align(

                                alignment: Alignment.centerLeft,

                                child: Container(

                                  width: 210,

                                  decoration: BoxDecoration(

                                    gradient: LinearGradient(

                                      colors: [

                                        Colors.white.withValues(
                                          alpha: 0,
                                        ),

                                        const Color(0xFFFF5106),
                                      ],

                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),

                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // BANNERS
              SizedBox(
                height: 156,

                child: ListView(
                  scrollDirection: Axis.horizontal,

                  padding: const EdgeInsets.only(left: 20),

                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),

                      child: Image.asset(
                        'assets/images/learning_banner.png',

                        width: 249,
                        height: 156,

                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 12),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),

                      child: Image.asset(
                        'assets/images/course_banner.png',

                        width: 249,
                        height: 140,

                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 20),
                  ],
                ),
              ),

              const SizedBox(height: 23),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Learning Plan',
                    style: AppTextStyles.s18w600.copyWith(
                      color: isDark
                          ? AppColors.lightText
                          : AppColors.darkText,
                    ),
                  ),
                ),
              ),
              // LEARNING PLAN
              Container(
                width: double.infinity,

                margin: const EdgeInsets.symmetric(horizontal: 20),

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,

                  borderRadius: BorderRadius.circular(18),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),

                      blurRadius: 10,

                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    const SizedBox(height: 18),

                    _planItem(
                      title: 'Packaging Design',
                      progress: '40/48',
                      value: 0.83,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 18),

                    _planItem(
                      title: 'Product Design',
                      progress: '6/24',
                      value: 0.25,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'more',
                        style: AppTextStyles.s14w400.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),

          const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/images/meetup.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

          const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }

  Widget _planItem({
    required String title,
    required String progress,
    required double value,
    required bool isDark,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 18,
          height: 18,

          child: CircularProgressIndicator(
            value: value,

            strokeWidth: 3,

            backgroundColor: isDark
                ? AppColors.findCourseBox
                : const Color(0xFFE5E5F0),

            valueColor: AlwaysStoppedAnimation(
              const Color(0xFF7A7A7A),
            ),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Text(
            title,

            style: AppTextStyles.s14w500.copyWith(
              color: isDark ? AppColors.lightText : AppColors.darkText,
            ),
          ),
        ),

        RichText(
          text: TextSpan(
            children: [

              TextSpan(
                text: progress.split('/')[0],
                style: AppTextStyles.s14w400.copyWith(
                  color: isDark
                      ? AppColors.lightText
                      : AppColors.darkText,
                ),
              ),

              TextSpan(
                text: '/${progress.split('/')[1]}',
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.greyText,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }


}
