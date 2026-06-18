import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/dialogs/success_dialog.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({
    super.key,
    this.phoneNumber = '283 835 2999',
  });

  final String phoneNumber;

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  static const _placeholderDigits = '3170';
  static const _codeLength = 4;

  String _code = '';

  void _addDigit(String digit) {
    if (_code.length >= _codeLength) return;
    setState(() => _code += digit);
  }

  void _removeDigit() {
    if (_code.isEmpty) return;
    setState(() => _code = _code.substring(0, _code.length - 1));
  }

  String _boxChar(int index) {
    if (index < _code.length) return _code[index];
    return _placeholderDigits[index];
  }

  bool _isPlaceholder(int index) => index >= _code.length;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightText,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color:
                          isDark ? AppColors.lightText : AppColors.darkText,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Verify Phone',
                        style: AppTextStyles.s18w600.copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              isDark ? AppColors.lightText : AppColors.darkText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            const SizedBox(height: 70),
            Text(
              'Code is sent to ${widget.phoneNumber}',
              style: AppTextStyles.s18w600.copyWith(
                color: AppColors.greyText,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _codeLength,
                (index) => Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0 : 19),
                  child: _otpBox(
                    char: _boxChar(index),
                    isPlaceholder: _isPlaceholder(index),
                    isDark: isDark,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: AppTextStyles.s12w400.copyWith(
                  color: AppColors.greyText,
                ),
                children: [
                  const TextSpan(text: "Didn't receive code? "),
                  TextSpan(
                    text: 'Request again',
                    style: AppTextStyles.s12w400.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 38),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 61),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierColor:
                          AppColors.darkBackground.withValues(alpha: 0.38),
                      builder: (_) => const SuccessDialog(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Verify and Create Account',
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.lightText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 68),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 40,
                  children: [
                    ...List.generate(9, (index) {
                      final digit = '${index + 1}';
                      return _numpadKey(
                        label: digit,
                        isDark: isDark,
                        onTap: () => _addDigit(digit),
                      );
                    }),
                    const SizedBox(),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpBox({
    required String char,
    required bool isPlaceholder,
    required bool isDark,
  }) {
    return Container(
      width: 50,
      height: 55,
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      alignment: Alignment.center,
      child: Text(
        char,
        style: AppTextStyles.s24w700.copyWith(
          color: isPlaceholder
              ? AppColors.greyText.withValues(alpha: 0.45)
              : (isDark ? AppColors.lightText : AppColors.darkText),
        ),
      ),
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
    );
  }
}
