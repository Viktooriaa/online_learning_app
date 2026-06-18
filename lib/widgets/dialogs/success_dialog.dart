import 'package:flutter/material.dart';
import 'package:online_learning_app/screens/main/main_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class SuccessDialog extends StatelessWidget {

  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {

    bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Dialog(

      backgroundColor: Colors.transparent,

      insetPadding: EdgeInsets.symmetric(horizontal: 48.w,
      ),

      child: Container(

        width: 291.w, height: 301.h,

        padding: EdgeInsets.symmetric(horizontal: 20.w,
          vertical: 24,
        ),

        decoration: BoxDecoration(

          color: isDark
              ? const Color(0xFF2F2F42)
              : Colors.white,

          borderRadius:
          BorderRadius.circular(12.r),
        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // CHECK ICON
            Container(

              width: 64.w, height: 64.h,

              decoration: const BoxDecoration(

                color: AppColors.primary,

                shape: BoxShape.circle,
              ),

              child: Icon(

                Icons.check,

                color: Colors.white,

                size: 40.w,
              ),
            ),

            SizedBox(height: 19.h),

            // TITLE
            Text(

              'Success',

              style:
              AppTextStyles.s18w600.copyWith(

                color: isDark
                    ? AppColors.lightText
                    : AppColors.darkText,
              ),
            ),

            SizedBox(height: 9.h),

            // SUBTITLE
            Text(

              'Congratulations, you have completed your registration!',

              maxLines: 2,

              overflow: TextOverflow.visible,

              textAlign: TextAlign.center,

              style:
              AppTextStyles.s12w400.copyWith(

                color: AppColors.greyText, height: 1.5,
              ),
            ),

            SizedBox(height: 15.h),

            // BUTTON
            SizedBox(

              width: double.infinity, height: 50.h,

              child: ElevatedButton(

                onPressed: () {

                  Navigator.pushReplacement(

                    context,

                    MaterialPageRoute(
                      builder: (_) => const MainScreen(),
                    ),
                  );
                },

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  AppColors.primary,

                  elevation: 0,

                  shape:
                  RoundedRectangleBorder(

                    borderRadius:
                    BorderRadius.circular(12.r),
                  ),
                ),

                child: Text(

                  'Done',

                  style:
                  AppTextStyles.s16w500.copyWith(

                    color:
                    AppColors.lightText,

                    fontWeight:
                    FontWeight.w600,
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