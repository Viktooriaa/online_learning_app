import 'package:flutter/material.dart';

import '../../widgets/empty_state_view.dart';

class NoProductsScreen extends StatelessWidget {
  const NoProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      kind: EmptyStateKind.products,
      title: 'No products',
      subtitle: 'You do not have any products yet',
    );
  }
}
