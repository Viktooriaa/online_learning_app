import 'package:flutter/material.dart';

import '../../widgets/empty_state_view.dart';
import '../search/search_screen.dart';

class NoVideosScreen extends StatelessWidget {
  const NoVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      kind: EmptyStateKind.videos,
      title: 'No videos!',
      subtitle: 'Here is no video you want at the moment',
      buttonText: 'Search more',
      onButtonPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        );
      },
    );
  }
}
