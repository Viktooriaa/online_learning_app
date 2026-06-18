import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/state/app_state.dart';
import '../progress/weekly_progress_screen.dart';

class PurchaseSuccessScreen extends StatelessWidget {
  const PurchaseSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: Column(
              children: [
                const Spacer(flex: 5),
                SvgPicture.asset(
                  'assets/icons/successful_purchase.svg',
                  width: 140,
                  height: 140,
                ),
                const SizedBox(height: 19),
                Text(
                  'Successful purchase!',
                  style: AppTextStyles.s16w500.copyWith(
                    color: textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      AppState.completePurchase();
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Start learning',
                      style: AppTextStyles.s16w500.copyWith(
                        color: Colors.white,
                        fontSize: 16,
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


