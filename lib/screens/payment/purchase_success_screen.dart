import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_colors.dart';
import '../progress/weekly_progress_screen.dart';
import 'providers/purchase_provider.dart';

class PurchaseSuccessScreen extends ConsumerWidget {
  const PurchaseSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.darkBackground : Colors.white;
    final textPrimary = isDark ? Colors.white : AppColors.darkText;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: background,
      ),
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 28.h),
            child: Column(
              children: [
                const Spacer(flex: 5),
                SvgPicture.asset(
                  'assets/icons/successful_purchase.svg', width: 140.w, height: 140.h,
                ),
                SizedBox(height: 19.h),
                Text(
                  AppStrings.successfulPurchase,
                  style: AppTextStyles.s16w500.copyWith(
                    color: textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity, height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(purchaseProvider.notifier).complete();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WeeklyProgressScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Start learning',
                      style: AppTextStyles.s16w500.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


