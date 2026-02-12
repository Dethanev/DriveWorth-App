import 'package:flutter/material.dart';
import 'package:drive_worth/src/config/app_colors.dart';
import 'widgets/personal_menu_tile.dart';
import 'widgets/personal_header.dart';
import 'package:drive_worth/src/shared/utils/sound.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.person, 'title': "個人中心"},
      {'icon': Icons.message, 'title': "訊息中心"},
      {'icon': Icons.image, 'title': "相簿中心"},
      {'icon': Icons.wifi, 'title': "網路設置"},
      {'icon': Icons.map, 'title': "地圖設置"},
      {'icon': Icons.category, 'title': "分類設置"},
    ];

    return Drawer(
      backgroundColor: AppColors.personalBackground,
      child: Column(
        children: [
          Header(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: menuItems.length,
              separatorBuilder:
                  (context, index) => const Divider(color: AppColors.white),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return MenuTile(
                  icon: item['icon'],
                  title: item['title'],
                  onTap: () {
                    Sound.click1();
                    // TODO: 實作導航邏輯
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
