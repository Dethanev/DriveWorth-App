import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class MenuTile extends StatelessWidget {
  // 1. 定義參數 (加上 final 表示這些值傳進來後不會變)
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  // 2. 在建構子 (Constructor) 接收這些參數
  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.personalMenuIcon,
        child: Icon(icon, color: AppColors.white),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: onTap,
    );
  }
}
