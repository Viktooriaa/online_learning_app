import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/custom_bottom_nav_bar.dart';
import '../course/course_screen.dart';
import '../search/search_screen.dart';
import 'account_screen.dart';
import 'home_screen.dart';
import 'message_screen.dart';
import 'providers/main_tab_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static const screens = [
    HomeScreen(),
    CourseScreen(),
    SearchScreen(),
    MessageScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainTabProvider);

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(mainTabProvider.notifier).select(index),
      ),
    );
  }
}
