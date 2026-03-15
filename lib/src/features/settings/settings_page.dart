import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../data/supabase/auth_service.dart';
import '../../shared/utils/sound.dart';

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
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text(title, style: AppTextStyles.h3),
        content: Text(content, style: AppTextStyles.body),
        actions: [
          TextButton(
            onPressed: () {
              Sound.click();
              Navigator.pop(context);
            },
            child: Text('確定', style: AppTextStyles.buttonSm),
          ),
        ],
      ),
    );
  }

  void _onClearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text('清除紀錄', style: AppTextStyles.h3),
        content: Text(
          '確定要清除所有快取與分析紀錄嗎？此動作無法復原。',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Sound.click();
              Navigator.pop(context);
            },
            child: Text('取消', style: AppTextStyles.buttonSm),
          ),
          TextButton(
            onPressed: () {
              Sound.click();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('清除完成', style: AppTextStyles.body)),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.statusDanger,
            ),
            child: Text('清除', style: AppTextStyles.buttonSm.copyWith(color: AppColors.statusDanger)),
          ),
        ],
      ),
    );
  }

  Future<void> _onLogout() async {
    await AuthService.signOut();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Sound.click();
            Navigator.pop(context);
          },
        ),
        title: Text('設定中心', style: AppTextStyles.h2),
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SettingsSectionHeader(title: '一般設定'),
            SettingsCard(
              children: [
                SettingsToggleTile(
                  title: '推播通知',
                  subtitle: '接收可疑來電與詐騙提醒通知',
                  value: _enableNotifications,
                  onChanged: (v) => setState(() => _enableNotifications = v),
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.divider),
                SettingsToggleTile(
                  title: '自動儲存分析紀錄',
                  subtitle: '將每次分析結果加入歷史紀錄',
                  value: _autoSaveHistory,
                  onChanged: (v) => setState(() => _autoSaveHistory = v),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const SettingsSectionHeader(title: '外觀與資料'),
            SettingsCard(
              children: [
                SettingsListTile(
                  title: '主題外觀',
                  subtitle: '目前使用淺色主題',
                  onTap: () => _showMessage('主題外觀', '目前僅提供淺色主題'),
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.divider),
                SettingsListTile(title: '清除快取與紀錄', onTap: _onClearCache),
              ],
            ),
            const SizedBox(height: 24),
            const SettingsSectionHeader(title: '關於'),
            SettingsCard(
              children: [
                SettingsListTile(
                  title: '關於我們',
                  onTap: () => _showMessage('關於我們', '駕值觀（DriveWorth）\n\n專注於愛車的持有成本與帳務管理，提供 TCO 分析、油價／稅金／保修紀錄與論壇交流，助你掌握每一筆駕值。\n\nVersion 1.0.0'),
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.divider),
                SettingsListTile(
                  title: '隱私權政策',
                  onTap: () => _showMessage('隱私權政策', '此為示意版 UI，無實際隱私權條款。'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Sound.click();
                    _onLogout();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.black, width: 3),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.black,
                          offset: Offset(4, 4),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '登出',
                        style: AppTextStyles.button.copyWith(color: AppColors.statusDanger),
                      ),
                    ),
                  ),
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
