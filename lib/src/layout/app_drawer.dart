import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:drive_worth/src/config/app_colors.dart';
import 'package:drive_worth/src/shared/utils/sound.dart';
import 'package:drive_worth/src/features/personal/profile_center_page.dart';
import 'package:drive_worth/src/features/history/history_center_page.dart';
import 'package:drive_worth/src/features/forum/forum_page.dart';
import 'package:drive_worth/src/features/forms/form_center_page.dart';
import 'package:drive_worth/src/features/support/support_center_page.dart';
import 'package:drive_worth/src/features/settings/settings_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _push(BuildContext context, Widget page) {
    Sound.click();
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      color:  Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GFDrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.secondary,
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/app_icon.png'),
              ),
            ),
            currentAccountPicture: GFAvatar(
              radius: 28,
              backgroundImage: const AssetImage('assets/images/Ethan.png'),
              shape: GFAvatarShape.circle,
            ),
            closeButton: const SizedBox.shrink(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ethan', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white)),
                Text('ethan@gmail.com', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.white)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _DrawerTile(
                  icon: Icons.person_rounded,
                  title: '個人中心',
                  onTap: () => _push(context, const ProfileCenterPage()),
                ),
                _DrawerTile(
                  icon: Icons.menu_book_rounded,
                  title: '知識中心',
                  onTap: () => _push(context, const ForumPage()),
                ),
                _DrawerTile(
                  icon: Icons.history_rounded,
                  title: '歷史中心',
                  onTap: () => _push(context, const HistoryCenterPage()),
                ),
                _DrawerTile(
                  icon: Icons.description_rounded,
                  title: '表單中心',
                  onTap: () => _push(context, const FormCenterPage()),
                ),
                _DrawerTile(
                  icon: Icons.support_agent_rounded,
                  title: '客服中心',
                  onTap: () => _push(context, const SupportCenterPage()),
                ),
                _DrawerTile(
                  icon: Icons.settings_rounded,
                  title: '設定中心',
                  onTap: () => _push(context, const SettingsPage()),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Sound.click();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, size: 22),
                label: Text('關閉', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: AppColors.borderLight),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  static const double _iconSize = 44;
  static TextStyle get _titleStyle => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.textPrimary, size: _iconSize),
              const SizedBox(width: 12),
              Text(title, style: _titleStyle),
            ],
          ),
        ),
      ),
    );
  }
}
