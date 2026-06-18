import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/empty_state_view.dart';
import 'no_notifications_screen.dart';

enum NotificationSection { message, notification }

class NotificationItem {
  const NotificationItem({
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
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key, this.notifications = _demoNotifications});

  static const _demoNotifications = [
    NotificationItem(
      iconPath: 'assets/icons/notification_wallet.svg',
      iconBackgroundColor: Color(0xFFFFE7EE),
      iconWidth: 18,
      iconHeight: 15,
      title: 'Successful purchase!',
      time: 'Just now',
    ),
    NotificationItem(
      iconPath: 'assets/icons/notification_chat.svg',
      iconBackgroundColor: AppColors.cardLight,
      iconWidth: 18,
      iconHeight: 18,
      title: 'Congratulations on completing the...',
      time: 'Just now',
    ),
    NotificationItem(
      iconPath: 'assets/icons/notification_chat.svg',
      iconBackgroundColor: AppColors.cardLight,
      iconWidth: 18,
      iconHeight: 18,
      title: 'Your course has been updated, you...',
      time: 'Just now',
    ),
    NotificationItem(
      iconPath: 'assets/icons/notification_chat.svg',
      iconBackgroundColor: AppColors.cardLight,
      iconWidth: 18,
      iconHeight: 18,
      title: 'Congratulations, you have...',
      time: 'Just now',
    ),
  ];

  final List<NotificationItem> notifications;

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
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
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: AppTextStyles.s24w700.copyWith(
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 15),
                NotificationTabs(
                  active: NotificationSection.notification,
                  onMessageTap: () => Navigator.maybePop(context),
                  onNotificationTap: () {},
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: NotificationList(notifications: notifications),
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
            label: 'message',
            isActive: active == NotificationSection.message,
            onTap: onMessageTap,
          ),
        ),
        Expanded(
          child: _TabLabel(
            label: 'notification',
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
                const SizedBox(width: 4),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: isActive ? 68 : 0,
            height: 2,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(4),
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
          title: 'No Notifications yet!',
          subtitle: 'We will notify you once we have something for you',
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
          const SizedBox(height: 12),
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
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0 : 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: iconWidth,
                height: iconHeight,
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 11, color: mutedColor),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: AppTextStyles.s12w400.copyWith(
                        color: mutedColor,
                        fontSize: 12,
                        height: 1,
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