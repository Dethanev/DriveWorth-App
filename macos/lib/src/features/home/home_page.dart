import 'package:flutter/material.dart';
import 'package:drive_worth/src/shared/utils/sound.dart';
import '../../config/app_text_styles.dart';
import '../../config/app_colors.dart';
import 'widgets/summary_card.dart';
import 'widgets/quick_actions_grid.dart';
import 'widgets/recent_history_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbar,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.white),
        title: Text("鷹眼守護", style: TextStyle(color: AppColors.white)),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Sound.click2();
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Sound.click2();
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SummaryCard(),
              SizedBox(height: 32),
              Text('快速分析', style: AppTextStyles.h2),
              SizedBox(height: 16),
              QuickActionsGrid(),
              SizedBox(height: 32),
              _RecentHistoryHeader(),
              SizedBox(height: 8),
              RecentHistoryList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentHistoryHeader extends StatelessWidget {
  const _RecentHistoryHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('最近紀錄', style: AppTextStyles.h2),
        TextButton(
          onPressed: () {
            // TODO: 實作查看全部紀錄功能（導航到完整歷史頁面）
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('查看全部紀錄')));
          },
          child: const Text('查看全部'),
        ),
      ],
    );
  }
}
