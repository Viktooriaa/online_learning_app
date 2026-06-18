import 'package:flutter/material.dart';
import 'package:online_learning_app/screens/auth/log_in_screen.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

import '../auth/sign_up_screen.dart';
import 'onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentIndex = 0;

  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      image: 'assets/images/onboarding1.png',

      title: 'Numerous free\ntrial courses',

      description: 'Free courses for you to\nfind your way to learning',

      showBackground: true,
      showButtons: false,
    ),

    OnboardingModel(
      image: 'assets/images/onboarding2.png',

      title: 'Quick and easy\nlearning',

      description:
          'Easy and fast learning at\nany time to help you\nimprove various skills',

      showBackground: true,
      showButtons: false,
    ),

    OnboardingModel(
      image: 'assets/images/onboarding3.png',

      title: 'Create your own\nstudy plan',

      description:
          'Study according to the\nstudy plan, make study\nmore motivated',

      showBackground: false,
      showButtons: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightText,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              const SizedBox(height: 55),
              // Skip
              if (currentIndex != 2)
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LogInScreen(),
                        ),
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

              const SizedBox(height: 12),

              // Pages
              Expanded(
                child: PageView.builder(
                  controller: _pageController,

                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },

                  itemCount: onboardingData.length,

                  itemBuilder: (context, index) {
                    final item = onboardingData[index];

                    return Column(
                      children: [
                        // Image
                        item.showBackground
                            ? Container(
                                height: 260,
                                width: 260,

                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.transparent
                                      : AppColors.onboardingBackground,

                                  borderRadius: BorderRadius.circular(57),

                                  border: index == 0
                                      ? Border.all(
                                          color: AppColors.darkText,
                                          width: 1,
                                        )
                                      : null,
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(20),

                                  child: Image.asset(item.image),
                                ),
                              )
                            : Image.asset(item.image, height: 260),

                        const SizedBox(height: 32),

                        // Title
                        Text(
                          item.title,

                          textAlign: TextAlign.center,

                          style: AppTextStyles.s22w700.copyWith(
                            color: isDark
                                ? AppColors.lightText
                                : AppColors.darkText,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Description
                        Text(
                          item.description,

                          textAlign: TextAlign.center,

                          style: AppTextStyles.s16w400,
                        ),

                        const SizedBox(height: 26),

                        // Dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: List.generate(onboardingData.length, (
                            dotIndex,
                          ) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),

                              width: currentIndex == dotIndex ? 20 : 6,

                              height: 6,

                              decoration: BoxDecoration(
                                color: currentIndex == dotIndex
                                    ? AppColors.primary
                                    : AppColors.border,

                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }),
                        ),

                        if (item.showButtons) const SizedBox(height: 82),

                        // Buttons
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
                                        builder: (_) => const SignUpScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: SecondaryButton(
                                  text: 'Log in',
                                  onPressed: () {

                                    Navigator.push(

                                      context,

                                      MaterialPageRoute(
                                        builder: (_) => const LogInScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
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
