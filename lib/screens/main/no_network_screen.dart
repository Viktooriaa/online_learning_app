import 'package:flutter/material.dart';

import '../../widgets/empty_state_view.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      kind: EmptyStateKind.network,
      title: 'No Network!',
      subtitle: 'Please check your internet connection and try again',
      buttonText: 'Try again',
      onButtonPressed: () => Navigator.maybePop(context),
    );
  }
}
