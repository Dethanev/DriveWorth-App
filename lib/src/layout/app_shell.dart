import 'package:flutter/material.dart';
import 'package:drive_worth/src/shared/utils/sound.dart';
import '../features/personal/personal_page.dart';
import '../features/story/story_page.dart';
import 'app_bottom_nav.dart';
import '../features/home/home_page.dart';
import '../features/analyze/analyze_page.dart';
import '../features/forum/forum_page.dart';
import '../features/settings/settings_page.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    AnalyzePage(),
    ForumPage(),
    SettingsPage(),
  ];

  void _onTabTapped(int index) {
    Sound.click5();
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      drawer: const Drawer(child: PersonalPage()),
      endDrawer: const Drawer(child: StoryPage()),
    );
  }
}
