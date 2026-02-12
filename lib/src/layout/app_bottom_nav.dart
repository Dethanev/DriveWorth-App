import 'package:flutter/material.dart';
import '../config/app_colors.dart';

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
      selectedItemColor: currentIndex == 0 ? AppColors.white : AppColors.black,
      unselectedItemColor: AppColors.textSecondary,
      
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: '首頁',
          backgroundColor: AppColors.appbar,
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.shield_rounded),
          label: '分析',
          backgroundColor: AppColors.background,
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.forum_rounded),
          label: '論壇',
          backgroundColor: AppColors.background,
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          label: '設定',
          backgroundColor: AppColors.background,
        ),
      ],
    );
  }
}