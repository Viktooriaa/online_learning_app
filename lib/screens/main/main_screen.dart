import 'package:flutter/material.dart';

import 'home_screen.dart';
import '../course/course_screen.dart';

// тимчасово
import '../search/search_screen.dart';
import 'message_screen.dart';
import 'account_screen.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final screens = [
    const HomeScreen(),
    const CourseScreen(),
    const SearchScreen(),
    const MessageScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
