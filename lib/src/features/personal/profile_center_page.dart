import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';

class ProfileCenterPage extends StatelessWidget {
  const ProfileCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('個人中心', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: const AssetImage('assets/images/Ethan.png'),
                  backgroundColor: AppColors.divider,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Ethan',
                style: AppTextStyles.h2,
              ),
              const SizedBox(height: 4),
              Text(
                'ethan@gmail.com',
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              Text(
                '帳號與車輛資料可在此管理',
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
