import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: '首頁',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_rounded),
          label: '分析',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_rounded),
          label: '知識',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          label: '設定',
        ),
      ],
    );
  }
}