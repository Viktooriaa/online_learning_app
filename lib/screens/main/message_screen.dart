import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/empty_state_view.dart';
import '../../core/utils/network_guard.dart';
import 'models/main_models.dart';
import 'notification_screen.dart';
import 'providers/message_provider.dart';

class MessageScreen extends ConsumerWidget {
  const MessageScreen({
    super.key,
    this.messages,
    this.hasNotifications = true,
  });

  final List<MessageItem>? messages;
  final bool hasNotifications;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MessageItem> items = messages ?? ref.watch(messagesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.darkBackground : Colors.white;
    final titleColor = isDark ? Colors.white : AppColors.darkText;

    return Scaffold(
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
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15.h),
              NotificationTabs(
                active: NotificationSection.message,
                onMessageTap: () {},
                onNotificationTap: () {
                  NetworkGuard.push(
                    context,
                    () => hasNotifications
                        ? const NotificationScreen()
                        : const NotificationScreen(notifications: []),
                  );
                },
              ),
              SizedBox(height: 18.h),
              Expanded(child: _MessageList(messages: items)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({required this.messages});

  final List<MessageItem> messages;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
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
      padding: EdgeInsets.only(bottom: 20.h),
      children: [
        for (final item in messages) ...[
          _MessageCard(
            name: item.name,
            status: item.status,
            time: item.time,
            text: item.text,
            hasPreview: item.hasPreview,
          ),
          SizedBox(height: 12.h),
        ],
      ],
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({
    required this.name,
    required this.status,
    required this.time,
    required this.text,
    this.hasPreview = false,
  });

  final String name;
  final String status;
  final String time;
  final String text;
  final bool hasPreview;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark ? const Color(0xFF2F3048) : Colors.white;

    final textColor = isDark ? Colors.white : AppColors.darkText;

    final mutedColor = isDark
        ? const Color(0xFFB8B8D2)
        : const Color(0xFF858597);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: hasPreview ? 293 : 120,
      ),

      padding: EdgeInsets.all(16.w),

      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// верх
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: 48.w, height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD8FFEF),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            name,
                            style: AppTextStyles.s14w500.copyWith(
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                        ),

                        Text(
                          time,
                          style: AppTextStyles.s12w400.copyWith(
                            color: mutedColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 3.h),

                    Text(
                      status,
                      style: AppTextStyles.s12w400.copyWith(
                        color: mutedColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          /// текст повідомлення
          Text(
            text,
            style: AppTextStyles.s12w400.copyWith(
              color: mutedColor, height: 1.45,
            ),
          ),

          if (hasPreview) ...[
            SizedBox(height: 16.h),

            Container(
              width: double.infinity, height: 145.h,
              decoration: BoxDecoration(
                color: const Color(0xFFFFE7EE),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
