import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/network_guard.dart';
import 'my_courses_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.darkBackground : Colors.white;
    final titleColor = isDark ? Colors.white : AppColors.darkText;
    final dividerColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFF0F0F6);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account',
                style: AppTextStyles.s24w700.copyWith(
                  color: titleColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 23),
              Center(
                child: Image.asset(
                  'assets/images/avatar_account.png',
                  width: 64,
                  height: 89,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 13),
              _AccountItem(
                title: 'Favourite',
                titleColor: titleColor,
                dividerColor: dividerColor,
                onTap: () => NetworkGuard.push(
                  context,
                  () => const MyCoursesScreen(),
                ),
              ),
              const SizedBox(height: 15),
              _AccountItem(
                title: 'Edit Account',
                titleColor: titleColor,
                dividerColor: dividerColor,
              ),
              const SizedBox(height: 15),
              _AccountItem(
                title: 'Settings and Privacy',
                titleColor: titleColor,
                dividerColor: dividerColor,
              ),
              const SizedBox(height: 15),
              _AccountItem(
                title: 'Help',
                titleColor: titleColor,
                dividerColor: dividerColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountItem extends StatelessWidget {
  const _AccountItem({
    required this.title,
    required this.titleColor,
    required this.dividerColor,
    this.onTap,
  });

  final String title;
  final Color titleColor;
  final Color dividerColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          // border: Border(bottom: BorderSide(color: dividerColor)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.s16w500.copyWith(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: titleColor.withValues(alpha: 0.62),
            ),
          ],
        ),
      ),
    );
  }
}
