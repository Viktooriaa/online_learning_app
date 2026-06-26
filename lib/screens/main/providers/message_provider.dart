import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_strings.dart';
import '../models/main_models.dart';

final messagesProvider = Provider<List<MessageItem>>((ref) {
  return const [
    MessageItem(
      name: AppStrings.bertPullman,
      status: AppStrings.online,
      time: AppStrings.messageTime,
      text: AppStrings.congratulationsMessage,
    ),
    MessageItem(
      name: AppStrings.danielLawson,
      status: AppStrings.online,
      time: AppStrings.messageTime,
      text: AppStrings.courseUpdatedMessage,
      hasPreview: true,
    ),
    MessageItem(
      name: AppStrings.nguyenShane,
      status: AppStrings.offline,
      time: AppStrings.midnight,
      text: AppStrings.registrationMessage,
      hasPreview: true,
    ),
  ];
});
