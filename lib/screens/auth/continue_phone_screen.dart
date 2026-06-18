import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

import 'verify_phone_screen.dart';

class ContinuePhoneScreen extends StatefulWidget {
  const ContinuePhoneScreen({super.key});

  @override
  State<ContinuePhoneScreen> createState() => _ContinuePhoneScreenState();
}

class _ContinuePhoneScreenState extends State<ContinuePhoneScreen> {
  static const _placeholder = '+63 283 835 2999';
  static const _maxDigits = 10;

  String _digits = '';

  String get _displayPhone {
    if (_digits.isEmpty) return _placeholder;

    final buffer = StringBuffer('+63 ');
    for (var i = 0; i < _digits.length; i++) {
      if (i == 3 || i == 6) buffer.write(' ');
      buffer.write(_digits[i]);
    }
    return buffer.toString();
  }

  String get _formattedForVerify {
    if (_digits.isEmpty) return '283 835 2999';
    final buffer = StringBuffer();
    for (var i = 0; i < _digits.length; i++) {
      if (i == 3 || i == 6) buffer.write(' ');
      buffer.write(_digits[i]);
    }
    return buffer.toString();
  }

  void _addDigit(String digit) {
    if (_digits.length >= _maxDigits) return;
    setState(() => _digits += digit);
  }

  void _removeDigit() {
    if (_digits.isEmpty) return;
    setState(() => _digits = _digits.substring(0, _digits.length - 1));
  }

  void _continue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VerifyPhoneScreen(
          phoneNumber: _formattedForVerify,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPlaceholder = _digits.isEmpty;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 52),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color:
                          isDark ? AppColors.lightText : AppColors.darkText,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Continue with Phone',
                        style: AppTextStyles.s14w400.copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              isDark ? AppColors.lightText : AppColors.darkText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                ],
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: 124,
              height: 124,
              child: Image.asset(
                'assets/images/continue_with_phone.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 42),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: 12,
                  bottom: 22,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 14),
                    Text(
                      'Enter Your Phone Number',
                      style: AppTextStyles.s14w400.copyWith(
                        color: AppColors.greyText,
                      ),
                    ),
                    const SizedBox(height: 23),
                    Container(
                      height: 58,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkBackground
                            : AppColors.lightText,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                              ),
                              child: Text(
                                _displayPhone,
                                style: AppTextStyles.s18w600.copyWith(
                                  color: isPlaceholder
                                      ? AppColors.greyText
                                      : (isDark
                                          ? AppColors.lightText
                                          : AppColors.darkText),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 58,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(18),
                                onTap: _continue,
                                child: Center(
                                  child: Text(
                                    'Continue',
                                    style: AppTextStyles.s14w400.copyWith(
                                      color: AppColors.lightText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 51),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _numberRow(['1', '2', '3'], isDark),
                            _numberRow(['4', '5', '6'], isDark),
                            _numberRow(['7', '8', '9'], isDark),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 24),
                                _numpadKey(
                                  label: '0',
                                  isDark: isDark,
                                  onTap: () => _addDigit('0'),
                                ),
                                _numpadKey(
                                  icon: Icons.backspace_outlined,
                                  isDark: isDark,
                                  onTap: _removeDigit,
                                ),
                              ],
                            ),
                          ],
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
    );
  }

  Widget _numberRow(List<String> numbers, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: numbers
          .map(
            (number) => _numpadKey(
              label: number,
              isDark: isDark,
              onTap: () => _addDigit(number),
            ),
          )
          .toList(),
    );
  }

  Widget _numpadKey({
    String? label,
    IconData? icon,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  size: 20,
                  color: isDark ? AppColors.lightText : AppColors.darkText,
                )
              : Text(
                  label!,
                  style: AppTextStyles.s24w700.copyWith(
                    color: isDark ? AppColors.lightText : AppColors.darkText,
                  ),
                ),
        ),
      ),
    );
  }
}
