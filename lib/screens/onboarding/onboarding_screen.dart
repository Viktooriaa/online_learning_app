import 'package:flutter/material.dart';
import 'package:online_learning_app/screens/auth/log_in_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

import '../auth/sign_up_screen.dart';
import 'providers/onboarding_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final currentIndex = ref.watch(onboardingIndexProvider);
    final onboardingData = ref.watch(onboardingItemsProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightText,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),

          child: Column(
            children: [
              SizedBox(height: 55.h),
              // Skip
              if (currentIndex != 2)
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LogInScreen()),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: AppTextStyles.s14w400.copyWith(
                        color: isDark
                            ? AppColors.lightText
                            : AppColors.darkText,
                      ),
                    ),
                  ),
                ),

              SizedBox(height: 12.h),

              // Pages
              Expanded(
                child: PageView.builder(
                  controller: _pageController,

                  onPageChanged: (index) =>
                      ref.read(onboardingIndexProvider.notifier).select(index),

                  itemCount: onboardingData.length,

                  itemBuilder: (context, index) {
                    final item = onboardingData[index];

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Column(
                              children: [
                                item.showBackground
                                    ? Container(
                                        height: 260.h,
                                        width: 260.w,
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Colors.transparent
                                              : AppColors.onboardingBackground,
                                          borderRadius: BorderRadius.circular(
                                            57.r,
                                          ),
                                          border: index == 0
                                              ? Border.all(
                                                  color: AppColors.darkText,
                                                  width: 1.w,
                                                )
                                              : null,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20.w),
                                          child: Image.asset(item.image),
                                        ),
                                      )
                                    : Image.asset(item.image, height: 260.h),
                                SizedBox(height: 32.h),
                                Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.s22w700.copyWith(
                                    color: isDark
                                        ? AppColors.lightText
                                        : AppColors.darkText,
                                  ),
                                ),
                                SizedBox(height: 18.h),
                                Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.s16w400,
                                ),
                                SizedBox(height: 26.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    onboardingData.length,
                                    (dotIndex) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 4.w,
                                        ),
                                        width: currentIndex == dotIndex
                                            ? 20
                                            : 6,
                                        height: 6.h,
                                        decoration: BoxDecoration(
                                          color: currentIndex == dotIndex
                                              ? AppColors.primary
                                              : AppColors.border,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                if (item.showButtons) SizedBox(height: 82.h),
                                if (item.showButtons)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: PrimaryButton(
                                          text: 'Sign up',
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const SignUpScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: SecondaryButton(
                                          text: 'Log in',
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const LogInScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
