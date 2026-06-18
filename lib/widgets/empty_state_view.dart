import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

enum EmptyStateKind { notifications, network, videos, products }

extension EmptyStateKindAsset on EmptyStateKind {
  String get imageAsset {
    switch (this) {
      case EmptyStateKind.notifications:
        return 'assets/images/no_notifcations.png';
      case EmptyStateKind.network:
        return 'assets/images/no_network.png';
      case EmptyStateKind.videos:
        return 'assets/images/no_videos.png';
      case EmptyStateKind.products:
        return 'assets/images/no_products.png';
    }
  }
}

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    required this.kind,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonPressed,
    this.showBackButton = true,
  });

  final EmptyStateKind kind;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.darkBackground : Colors.white;
    final titleColor = isDark ? Colors.white : AppColors.darkText;

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
              if (showBackButton)
                Positioned(
                  left: 20,
                  top: 18,
                  child: GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18.w,
                      color: titleColor,
                    ),
                  ),
                ),
              Center(
                child: EmptyStateBody(
                  kind: kind,
                  title: title,
                  subtitle: subtitle,
                  buttonText: buttonText,
                  onButtonPressed:
                      onButtonPressed ?? () => Navigator.maybePop(context),
                  yOffset: -38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyStateBody extends StatelessWidget {
  const EmptyStateBody({
    super.key,
    required this.kind,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonPressed,
    this.yOffset = 0,
  });

  final EmptyStateKind kind;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final double yOffset;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : AppColors.darkText;
    final mutedColor = isDark
        ? const Color(0xFFB8B8D2)
        : const Color(0xFF858597);

    return Transform.translate(
      offset: Offset(0, yOffset),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 42.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmptyStateIllustration(kind: kind, width: 240.w),
            SizedBox(height: 18.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.s14w500.copyWith(
                color: titleColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700, height: 1,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.s10w400.copyWith(
                color: mutedColor,
                fontSize: 10.sp, height: 1.35,
              ),
            ),
            if (buttonText != null) ...[
              SizedBox(height: 24.h),
              SizedBox(width: 146.w, height: 42.h,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                  child: Text(
                    buttonText!,
                    style: AppTextStyles.s12w500.copyWith(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyStateIllustration extends StatelessWidget {
  const EmptyStateIllustration({
    super.key,
    required this.kind,
    this.width = 240,
  });

  final EmptyStateKind kind;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      kind.imageAsset,
      width: width,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}
