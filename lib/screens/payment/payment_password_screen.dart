import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_colors.dart';
import 'purchase_success_screen.dart';

class PaymentPasswordScreen extends StatefulWidget {
  const PaymentPasswordScreen({super.key});

  @override
  State<PaymentPasswordScreen> createState() =>
      _PaymentPasswordScreenState();
}

class _PaymentPasswordScreenState
    extends State<PaymentPasswordScreen> {

  final List<String> _password = [];

  void _onKeyTap(String value) {

    if (value == 'backspace') {
      if (_password.isNotEmpty) {
        setState(() {
          _password.removeLast();
        });
      }
      return;
    }

    if (_password.length < 6) {
      setState(() {
        _password.add(value);
      });
    }

    if (_password.length == 6) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const PurchaseSuccessScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.darkBackground : Colors.white;
    final cardColor = isDark ? const Color(0xFF2F3048) : Colors.white;
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
          child: Stack(
            children: [
            Positioned(
            left: 24,
            top: 18,
            child: GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Icon(
                Icons.close_rounded,
                size: 18.w,
                color: isDark ? Colors.white : AppColors.darkText,
              ),
            ),
          ),
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Payment Method',
                    style: AppTextStyles.s12w500.copyWith(
                      color: isDark ? Colors.white : AppColors.darkText,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          Positioned(
                left: 20,
                right: 20,
                top: 8,
                child: Opacity(
                  opacity: isDark ? 0.42 : 0.76,
                  child: const _MiniCard(),
                ),
              ),
              Positioned(
                top: 135,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '\$74.00',
                    style: AppTextStyles.s24w700.copyWith(
                      color: textPrimary,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 250,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28.r),
                  ),
                  child: Container(
                    color: cardColor,
                    padding: EdgeInsets.fromLTRB(
                      26,
                      28,
                      26,
                      18 + MediaQuery.of(context).padding.bottom,
                    ),
                    child: Column(

                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Payment Password',
                          style: AppTextStyles.s24w700.copyWith(
                            color: textPrimary,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Please enter the payment password',
                          style: AppTextStyles.s12w400.copyWith(
                            color: textMuted,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 22.h),
                        _PasswordDots(
                          isDark: isDark,
                          filledCount: _password.length,
                        ),
                        SizedBox(height: 26.h),
                        _Keypad(
                          textPrimary: textPrimary,
                          onKeyTap: _onKeyTap,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(20.w, 0.h),
      child: Image.asset(
        'assets/images/card.png',
        fit: BoxFit.contain,
      ),
    );
  }
}

class _PasswordDots extends StatelessWidget {
  const _PasswordDots({
    required this.isDark,
    required this.filledCount,
  });

  final bool isDark;
  final int filledCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) => Container(
          width: 44.w, height: 55.h,
          decoration: BoxDecoration(
            color: index < filledCount
                ? (isDark ? const Color(0xFF4A4A66) : Colors.white)
                : (isDark ? const Color(0xFF45455F) : const Color(0xFFF7F7FD)),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isDark ? Colors.transparent : const Color(0xFFE7E7F2),
            ),
          ),
          alignment: Alignment.center,
          child: index < filledCount
              ? Container(
                  width: 8.w, height: 8.h,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white : AppColors.darkText,
                    shape: BoxShape.circle,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({
    required this.textPrimary,
    required this.onKeyTap,
  });

  static const _backspace = 'backspace';

  final Color textPrimary;
  final Function(String) onKeyTap;

  @override
  Widget build(BuildContext context) {
    const keys = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '',
      '0',
      _backspace,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 26,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        final value = keys[index];

        return GestureDetector(
          onTap: value.isEmpty
              ? null
              : () => onKeyTap(value),
          child: Center(
            child: value == _backspace
                ? Icon(
              Icons.backspace_outlined,
              size: 16.w,
              color: textPrimary,
            )
                : Text(
              value,
              style: AppTextStyles.s18w600.copyWith(
                color: textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }
}
