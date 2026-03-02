import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 從 Supabase 獲取當前使用者資訊
    return const UserAccountsDrawerHeader(
      accountName: Text(
        "Ethan",
        style: TextStyle(color: AppColors.white),
      ), // TODO: 使用 Supabase user.name
      accountEmail: Text(
        "ethan@gmail.com",
        style: TextStyle(color: AppColors.white),
      ), // TODO: 使用 Supabase user.email
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage("assets/images/Ethan.png"),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/app_icon.png"),
        ),
      ),
    );
  }
}
