import 'package:flutter/material.dart';
import 'package:online_learning_app/screens/auth/continue_phone_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import 'log_in_screen.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() =>
      _SignUpScreenState();
}

class _SignUpScreenState
    extends State<SignUpScreen> {

  bool isChecked = false;

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

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    'Sign Up',

                    style:
                    AppTextStyles.s32w700.copyWith(
                      fontWeight: FontWeight.w800,

                      color: isDark
                          ? AppColors.lightText
                          : AppColors.darkText, height: 1,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(

                    'Enter your details below & free sign up',

                    style:
                    AppTextStyles.s12w400.copyWith(

                      color: isDark
                          ? AppColors.greyText
                          : AppColors.border,
                    ),
                  ),
                ],
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
                      ? const Color(0xFF2B2B45)
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
                          color: isDark
                              ? AppColors.border
                              : AppColors.greyText,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      const CustomTextField(
                        hintText:
                        'Cooper_Kristin@gmail.com',
                      ),

                      SizedBox(height: 25.h),

                      // PASSWORD
                      Text(

                        'Password',

                        style:
                        AppTextStyles.s12w400.copyWith(
                          color: isDark
                              ? AppColors.border
                              : AppColors.greyText,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      const CustomTextField(
                        hintText: '••••••••••••',
                        obscureText: true,
                      ),

                      SizedBox(height: 24.h),

                      // BUTTON
                      PrimaryButton(
                        text: 'Creat account',
                        onPressed: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(
                              builder: (_) => const ContinuePhoneScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 14.h),

                      // CHECKBOX
                      Row(

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          GestureDetector(

                            onTap: () {

                              setState(() {
                                isChecked = !isChecked;
                              });
                            },

                            child: Container(

                              width: 14.w, height: 14.h,

                              margin: EdgeInsets.only(top: 2.h,
                              ),

                              decoration: BoxDecoration(

                                color: isChecked
                                    ? AppColors.primary
                                    : Colors.transparent,

                                border: Border.all(
                                  color: AppColors.border,
                                ),

                                borderRadius:
                                BorderRadius.circular(3.r),
                              ),

                              child: isChecked

                                  ? Icon(
                                Icons.check,
                                size: 10.w,
                                color: Colors.white,
                              )

                                  : null,
                            ),
                          ),

                          SizedBox(width: 8.w),

                          Expanded(

                            child: Text(

                              'By creating an account you have to agree with our them & condication.',

                              style:
                              AppTextStyles.s12w400.copyWith(
                                color: AppColors.greyText, height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 22.h),

                      // LOGIN
                      Center(

                        child: RichText(

                          text: TextSpan(

                            style:
                            AppTextStyles.s12w400.copyWith(

                              color: isDark
                                  ? AppColors.border
                                  : AppColors.greyText,
                            ),

                            children: [

                              const TextSpan(
                                text: 'Already have an account ? ',
                              ),

                              WidgetSpan(

                                alignment:
                                PlaceholderAlignment.middle,

                                child: GestureDetector(

                                  onTap: () {

                                    Navigator.pushReplacement(

                                      context,

                                      MaterialPageRoute(
                                        builder: (_) =>
                                        const LogInScreen(),
                                      ),
                                    );
                                  },

                                  child: Text(

                                    'Log in',

                                    style:
                                    AppTextStyles.s12w400.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700, height: 1,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primary,
                                      decorationThickness: 1.5,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}