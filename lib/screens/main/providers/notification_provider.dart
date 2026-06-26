import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../models/main_models.dart';

final notificationsProvider = Provider<List<NotificationItem>>((ref) {
  return const [
    NotificationItem(
      iconPath: 'assets/icons/notification_wallet.svg',
      iconBackgroundColor: AppColors.notificationPink,
      iconWidth: 18,
      iconHeight: 15,
      title: AppStrings.successfulPurchase,
      time: AppStrings.justNow,
    ),
    NotificationItem(
      iconPath: 'assets/icons/notification_chat.svg',
      iconBackgroundColor: AppColors.cardLight,
      iconWidth: 18,
      iconHeight: 18,
      title: AppStrings.completionPreview,
      time: AppStrings.justNow,
    ),
    NotificationItem(
      iconPath: 'assets/icons/notification_chat.svg',
      iconBackgroundColor: AppColors.cardLight,
      iconWidth: 18,
      iconHeight: 18,
      title: AppStrings.courseUpdatedPreview,
      time: AppStrings.justNow,
    ),
    NotificationItem(
      iconPath: 'assets/icons/notification_chat.svg',
      iconBackgroundColor: AppColors.cardLight,
      iconWidth: 18,
      iconHeight: 18,
      title: AppStrings.congratulationsPreview,
      time: AppStrings.justNow,
    ),
  ];
});
