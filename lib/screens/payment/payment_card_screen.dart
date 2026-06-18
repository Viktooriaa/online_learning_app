import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'payment_password_screen.dart';

class PaymentCardScreen extends StatelessWidget {
  const PaymentCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.darkBackground : Colors.white;
    final textPrimary = isDark ? Colors.white : AppColors.darkText;
    final textMuted = isDark ? const Color(0xFFB8B8D2) : AppColors.greyText;

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
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              children: [
                _TopBar(title: 'Payment Method', isDark: isDark),
                const SizedBox(height: 10),
                const _CreditCard(),
                const SizedBox(height: 14),

                const SizedBox(height: 6),
                Text(
                  '\$23,900.00',
                  style: AppTextStyles.s18w600.copyWith(
                    color: textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'My card',
                  style: AppTextStyles.s12w400.copyWith(
                    color: textMuted,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  '...',
                  style: AppTextStyles.s20w700.copyWith(
                    color: textPrimary,
                    fontSize: 24,
                    letterSpacing: 5,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PaymentPasswordScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Pay Now',
                      style: AppTextStyles.s12w500.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title, required this.isDark});

  final String title;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Icon(
              Icons.close_rounded,
              size: 16,
              color: isDark ? Colors.white : AppColors.darkText,
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.s12w500.copyWith(
                color: isDark ? Colors.white : AppColors.darkText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _CreditCard extends StatelessWidget {
  const _CreditCard();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(20, 0), 
      child: Image.asset(
        'assets/images/card.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
