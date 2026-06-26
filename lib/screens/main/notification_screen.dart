import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/empty_state_view.dart';
import 'models/main_models.dart';
import 'no_notifications_screen.dart';
import 'providers/notification_provider.dart';

enum NotificationSection { message, notification }

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key, this.notifications});

  final List<NotificationItem>? notifications;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<NotificationItem> items =
        notifications ?? ref.watch(notificationsProvider);

    if (items.isEmpty) {
      return const NoNotificationsScreen();
    }

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
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.notifications,
                  style: AppTextStyles.s24w700.copyWith(
                    color: titleColor,
                  ),
                ),
                SizedBox(height: 15.h),
                NotificationTabs(
                  active: NotificationSection.notification,
                  onMessageTap: () => Navigator.maybePop(context),
                  onNotificationTap: () {},
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: NotificationList(notifications: items),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationTabs extends StatelessWidget {
  const NotificationTabs({
    super.key,
    required this.active,
    required this.onMessageTap,
    required this.onNotificationTap,
  });

  final NotificationSection active;
  final VoidCallback onMessageTap;
  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TabLabel(
            label: AppStrings.message,
            isActive: active == NotificationSection.message,
            onTap: onMessageTap,
          ),
        ),
        Expanded(
          child: _TabLabel(
            label: AppStrings.notification,
            isActive: active == NotificationSection.notification,
            showDot: true,
            onTap: onNotificationTap,
          ),
        ),
      ],
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.label,
    required this.isActive,
    required this.onTap,
    this.showDot = false,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDark ? Colors.white : AppColors.darkText;
    final inactiveColor =
        isDark ? const Color(0xFFB8B8D2) : AppColors.greyText;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.s16w500.copyWith(
                  color: isActive ? activeColor : inactiveColor,
                ),
              ),
              if (showDot) ...[
                SizedBox(width: 4.w),
                Container(
                  width: 6.w, height: 6.h,
                  decoration: const BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8.h),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: isActive ? 68.w : 0,
            height: 2.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({super.key, required this.notifications});

  final List<NotificationItem> notifications;

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const Center(
        child: EmptyStateBody(
          kind: EmptyStateKind.notifications,
          title: AppStrings.noNotificationsTitle,
          subtitle: AppStrings.noNotificationsSubtitle,
          yOffset: -28,
        ),
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        for (final item in notifications) ...[
          _NotificationTile(
            iconPath: item.iconPath,
            iconBackgroundColor: item.iconBackgroundColor,
            iconWidth: item.iconWidth,
            iconHeight: item.iconHeight,
            title: item.title,
            time: item.time,
          ),
          SizedBox(height: 12.h),
        ],
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.iconPath,
    required this.iconBackgroundColor,
    required this.iconWidth,
    required this.iconHeight,
    required this.title,
    required this.time,
  });

  final String iconPath;
  final Color iconBackgroundColor;
  final double iconWidth;
  final double iconHeight;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF2F3048) : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.darkText;
    final mutedColor = isDark
        ? const Color(0xFFB8B8D2)
        : const Color(0xFF858597);

    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0 : 0.06),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w, height: 48.h,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: iconWidth.w,
                height: iconHeight.h,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s12w500.copyWith(
                    color: textColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700, height: 1,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 11.w, color: mutedColor),
                    SizedBox(width: 4.w),
                    Text(
                      time,
                      style: AppTextStyles.s12w400.copyWith(
                        color: mutedColor,
                        fontSize: 12.sp, height: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
