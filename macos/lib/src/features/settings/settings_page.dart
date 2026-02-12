import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';

import 'widgets/settings_section_header.dart';
import 'widgets/settings_card.dart';
import 'widgets/settings_toggle_tile.dart';
import 'widgets/settings_list_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _enableNotifications = true;
  bool _autoSaveHistory = true;

  void _showMessage(String title, String content) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('確定'),
              ),
            ],
          ),
    );
  }

  void _onClearCache() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('清除紀錄'),
            content: const Text('確定要清除所有快取與分析紀錄嗎？此動作無法復原。'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('清除完成')));
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.statusDanger,
                ),
                child: const Text('清除'),
              ),
            ],
          ),
    );
  }

  void _onLogout() {
    // TODO: 調用 Supabase 登出 API
    // await AuthService.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // === Group 1 ===
            const SettingsSectionHeader(title: '一般設定'),
            SettingsCard(
              children: [
                SettingsToggleTile(
                  title: '推播通知',
                  subtitle: '接收可疑來電與詐騙提醒通知',
                  value: _enableNotifications,
                  onChanged: (v) => setState(() => _enableNotifications = v),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SettingsToggleTile(
                  title: '自動儲存分析紀錄',
                  subtitle: '將每次分析結果加入歷史紀錄',
                  value: _autoSaveHistory,
                  onChanged: (v) => setState(() => _autoSaveHistory = v),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // === Group 2 ===
            const SettingsSectionHeader(title: '外觀與資料'),
            SettingsCard(
              children: [
                SettingsListTile(
                  title: '主題外觀',
                  subtitle: '目前使用淺色主題',
                  onTap: () => _showMessage('主題外觀', '目前僅提供淺色主題'),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SettingsListTile(title: '清除快取與紀錄', onTap: _onClearCache),
              ],
            ),

            const SizedBox(height: 24),

            // === Group 3 ===
            const SettingsSectionHeader(title: '關於'),
            SettingsCard(
              children: [
                SettingsListTile(
                  title: '關於我們',
                  onTap:
                      () =>
                          _showMessage('關於我們', '鷹眼守護 v1.0.0\n致力於打造最安全的防詐騙應用。'),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SettingsListTile(
                  title: '隱私權政策',
                  onTap: () => _showMessage('隱私權政策', '此為示意版 UI，無實際隱私權條款。'),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextButton(
                onPressed: _onLogout,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.statusDanger,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '登出',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                'Version 1.0.0 (Build 100)',
                style: AppTextStyles.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
