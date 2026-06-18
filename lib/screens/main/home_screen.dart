import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/network_guard.dart';
import 'my_courses_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              SizedBox(height: 220.h,

                child: Stack(
                  clipBehavior: Clip.none,

                  children: [
                    Container(
                      width: double.infinity, height: 170.h,

                      padding: EdgeInsets.only(left: 20.w,
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
                              SizedBox(height: 10.h),

                              Text(
                                'Hi, Kristin',

                                style: AppTextStyles.s24w700.copyWith(
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: 4.h),

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
                        padding: EdgeInsets.symmetric(horizontal: 16.w,
                          vertical: 16,
                        ),

                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : Colors.white,

                          borderRadius: BorderRadius.circular(18.r),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),

                              blurRadius: 10.r,

                              offset: Offset(0, 4.h),
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

                            SizedBox(height: 8.h),

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

                            SizedBox(height: 12.h),

                            Container(

                              width: double.infinity, height: 5.h,

                              decoration: BoxDecoration(

                                color: AppColors.progressBackground,

                                borderRadius:
                                BorderRadius.circular(20.r),
                              ),

                              child: Align(

                                alignment: Alignment.centerLeft,

                                child: Container(

                                  width: 210.w,

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
                                    BorderRadius.circular(20.r),
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

              SizedBox(height: 16.h),

              // BANNERS
              SizedBox(height: 156.h,

                child: ListView(
                  scrollDirection: Axis.horizontal,

                  padding: EdgeInsets.only(left: 20.w),

                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),

                      child: Image.asset(
                        'assets/images/learning_banner.png', width: 249.w, height: 156.h,

                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(width: 12.w),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),

                      child: Image.asset(
                        'assets/images/course_banner.png', width: 249.w, height: 140.h,

                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(width: 20.w),
                  ],
                ),
              ),

              SizedBox(height: 23.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,
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

                margin: EdgeInsets.symmetric(horizontal: 20.w),

                padding: EdgeInsets.all(18.w),

                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,

                  borderRadius: BorderRadius.circular(18.r),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),

                      blurRadius: 10.r,

                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    SizedBox(height: 18.h),

                    _planItem(
                      title: 'Packaging Design',
                      progress: '40/48',
                      value: 0.83,
                      isDark: isDark,
                    ),

                    SizedBox(height: 18.h),

                    _planItem(
                      title: 'Product Design',
                      progress: '6/24',
                      value: 0.25,
                      isDark: isDark,
                    ),

                    SizedBox(height: 16.h),
                    Center(
                      child: Text(
                        'more',
                        style: AppTextStyles.s14w400.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),
                  ],
                ),
              ),

          SizedBox(height: 14.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.r),
                    child: Image.asset(
                      'assets/images/meetup.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

          SizedBox(height: 110.h),
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
        SizedBox(width: 18.w, height: 18.h,

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

        SizedBox(width: 14.w),

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
