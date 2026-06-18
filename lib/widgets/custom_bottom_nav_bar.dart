import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  //static const double _searchCircleDiameter = 64.0;
  static const double _barHeight = 88.0;
  //static const double _indicatorHeight = 3.0;
  //static const double _indicatorWidth = 28.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color navBg = isDark ? const Color(0xFF1F1F39) : Colors.white;
    final Color searchBg =
    isDark ? const Color(0xFF25254B)
        : const Color(0xFFF4F5FA);

    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: _barHeight + bottomPadding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          // Бар
        Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        height: _barHeight + bottomPadding,
        child: Container(
          decoration: BoxDecoration(
            color: navBg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.r),
              topRight: Radius.circular(32.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: isDark ? 0.35 : 0.08,
                ),
                blurRadius: 20.r,
                offset: const Offset(0, -4),
              ),
            ],
          ),
              child: Column(
                children: [
                  SizedBox(
                    height: _barHeight,
                    child: Row(
                      children: [
                        _NavItem(iconPath: 'assets/icons/home.svg',    label: 'Home',    isSelected: currentIndex == 0, onTap: () => onTap(0)),
                        _NavItem(iconPath: 'assets/icons/course.svg',  label: 'Course',  isSelected: currentIndex == 1, onTap: () => onTap(1)),
                        SizedBox(width: 72.w,
                        ),
                        _NavItem(iconPath: 'assets/icons/message.svg', label: 'Message', isSelected: currentIndex == 3, onTap: () => onTap(3)),
                        _NavItem(iconPath: 'assets/icons/account.svg', label: 'Account', isSelected: currentIndex == 4, onTap: () => onTap(4)),
                      ],
                    ),
                  ),
                  SizedBox(height: bottomPadding),
                ],
              ),
            ),
          ),
          // Search коло
          Positioned(
            top: -18, left: 0, right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => onTap(2),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   // AnimatedContainer(
                     // duration: const Duration(milliseconds: 220),
                     // curve: Curves.easeOut,
                     // width: currentIndex == 2 ? _indicatorWidth : 0,
                     // height: _indicatorHeight,
                     // decoration: BoxDecoration(
                    //    color: AppColors.primary,
                    //    borderRadius: BorderRadius.circular(_indicatorHeight / 2),
                    //  ),
                   // ),
                   // SizedBox(height: 4.h),
                    Container(
                      width: 64.w, height: 64.h,
                      decoration: BoxDecoration(
                        color: searchBg,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 16.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/search.svg', width: 24.w, height: 24.h,
                          colorFilter: ColorFilter.mode(
                            currentIndex == 2
                                ? AppColors.primary
                                : AppColors.greyText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text('Search',
                      style: AppTextStyles.s12w400.copyWith(
                        fontSize: 11.sp,
                        fontWeight: currentIndex == 2 ? FontWeight.w600 : FontWeight.w500,
                        color: currentIndex == 2 ? AppColors.primary : AppColors.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.iconPath, required this.label,
    required this.isSelected, required this.onTap,
  });

  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  static const double _iconSize = 20.0;
  static const double _indicatorWidth = 28.0;
  static const double _indicatorHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? AppColors.primary : AppColors.greyText;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              width: isSelected ? _indicatorWidth : 0,
              height: _indicatorHeight,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(_indicatorHeight / 2),
              ),
            ),
            SizedBox(height: 8.h),
            SvgPicture.asset(iconPath, width: _iconSize, height: _iconSize,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
            SizedBox(height: 4.h),
            Text(label,
              style: AppTextStyles.s12w400.copyWith(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
