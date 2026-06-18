import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_learning_app/screens/auth/sign_up_screen.dart';
import 'package:online_learning_app/screens/main/main_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class LogInScreen extends StatelessWidget {

  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {

    bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(

      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,

      body: SafeArea(

        child: Column(

          children: [

            // HEADER
            Container(

              width: double.infinity,

              color: isDark
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,

              padding: EdgeInsets.only(left: 24.w,
                right: 24,
                top: 50,
                bottom: 24,
              ),

              child: Text(

                'Log In',

                style:
                AppTextStyles.s32w700.copyWith(
                  fontWeight: FontWeight.w800,

                  color: isDark
                      ? AppColors.lightText
                      : AppColors.darkText, height: 1,
                ),
              ),
            ),

            // FORM
            Expanded(

              child: Container(

                width: double.infinity,

                padding: EdgeInsets.symmetric(horizontal: 24.w,
                  vertical: 24,
                ),

                decoration: BoxDecoration(

                  color: isDark
                      ? AppColors.cardDark
                      : Colors.white,

                  borderRadius:
                  BorderRadius.only(

                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),

                ),

                child: SingleChildScrollView(

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      // EMAIL
                      Text(

                        'Your Email',

                        style:
                        AppTextStyles.s12w400.copyWith(
                          color: AppColors.greyText,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      const CustomTextField(
                        hintText:
                        'Cooper_Kristin@gmail.com',
                      ),

                      SizedBox(height: 20.h),

                      // PASSWORD
                      Text(

                        'Password',

                        style:
                        AppTextStyles.s12w400.copyWith(
                          color: AppColors.greyText,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      const CustomTextField(
                        hintText: '••••••••••••',
                        obscureText: true,
                      ),

                      SizedBox(height: 10.h),

                      // FORGOT PASSWORD
                      Align(

                        alignment: Alignment.centerRight,

                        child: Text(

                          'Forgot password?',

                          style:
                          AppTextStyles.s12w400.copyWith(
                            color: AppColors.greyText,
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // BUTTON
                      PrimaryButton(
                        text: 'Log In',
                        onPressed: () {

                          Navigator.pushReplacement(

                            context,

                            MaterialPageRoute(
                              builder: (_) => const MainScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 26.h),

                      // SIGN UP
                      Center(

                        child: Row(

                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [

                            Text(

                              "Don't have an account? ",

                              style:
                              AppTextStyles.s12w400.copyWith(
                                color: AppColors.greyText,
                              ),
                            ),

                            GestureDetector(

                              onTap: () {

                                Navigator.pushReplacement(

                                  context,

                                  MaterialPageRoute(
                                    builder: (_) => const SignUpScreen(),
                                  ),
                                );
                              },

                              child: Text(

                                'Sign up',

                                style:
                                AppTextStyles.s12w400.copyWith(
                                  color: AppColors.primary,
                                  fontWeight:
                                  FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30.h),

                      // DIVIDER
                      Row(

                        children: [

                          Expanded(

                            child: Container(
                              height: 1,
                              color: AppColors.border,
                            ),
                          ),

                          Padding(

                            padding:
                            EdgeInsets.symmetric(horizontal: 12.w,
                            ),

                            child: Text(

                              'Or login with',

                              style:
                              AppTextStyles.s12w400.copyWith(
                                color: AppColors.greyText,
                              ),
                            ),
                          ),

                          Expanded(

                            child: Container(
                              height: 1,
                              color: AppColors.border,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 28.h),

                      // SOCIAL
                      Row(

                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        children: [

                          // GOOGLE
                          SvgPicture.asset(
                            'assets/icons/google.svg', width: 42.w, height: 42.h,
                          ),

                          SizedBox(width: 45.w),

                          // FACEBOOK
                          SvgPicture.asset(
                            'assets/icons/facebook.svg', width: 42.w, height: 42.h,
                          ),
                        ],
                      ),
                    ],
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