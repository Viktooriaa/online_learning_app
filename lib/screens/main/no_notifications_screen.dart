import 'package:flutter/material.dart';

import '../../widgets/empty_state_view.dart';

class NoNotificationsScreen extends StatelessWidget {
  const NoNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      kind: EmptyStateKind.notifications,
      title: 'No Notifications yet!',
      subtitle: 'We will notify you once we have something for you',
    );
  }
}
