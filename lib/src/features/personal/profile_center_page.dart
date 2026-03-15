import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../data/supabase/auth_service.dart';
import '../../shared/utils/sound.dart';
import '../auth/providers/auth_state_provider.dart';
import '../settings/settings_page.dart';

class ProfileCenterPage extends ConsumerWidget {
  const ProfileCenterPage({super.key});

  static String _displayName(User? user, UserProfile? profile) {
    if (profile?.nickname != null && profile!.nickname!.isNotEmpty) {
      return profile.nickname!;
    }
    final email = user?.email;
    if (email != null && email.isNotEmpty) {
      return email.split('@').first;
    }
    return '使用者';
  }

  static const List<String> _greetings = [
    '今天也要精準掌握愛車成本喔!',
    '你的每筆紀錄都在幫你算得更準!',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profileAsync = ref.watch(userProfileProvider);
    final profile = profileAsync.valueOrNull;
    final displayName = _displayName(user, profile);
    final email = user?.email ?? '';
    final greeting = _greetings[DateTime.now().day % _greetings.length];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('個人中心', style: AppTextStyles.h2),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        scrolledUnderElevation: 0,
      ),
      body: user == null
          ? _buildLoggedOut(context)
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Sound.laugh();
                        if (!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content:  Text('還在開發啦 真的是！',style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.bold)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('好喔'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.transparent,
                            backgroundImage: (profile?.avatarUrl != null && profile!.avatarUrl!.isNotEmpty)
                                ? NetworkImage(profile.avatarUrl!)
                                : const AssetImage('assets/images/Ethan.png'),
                          ),
                          Positioned(
                            right: -4,
                            bottom: -4,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                border: Border.all(color: AppColors.black, width: 2),
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.black,
                                    offset: Offset(2, 2),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.camera_alt_rounded, size: 20, color: AppColors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(displayName, style: AppTextStyles.h2),
                    if (email.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Text(
                      '嗨，$displayName — $greeting',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 28),
                    _NeuCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('帳號資訊', style: AppTextStyles.h5),
                          const SizedBox(height: 8),
                          if (email.isNotEmpty)
                            Row(
                              children: [
                                Text('Email', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                                const SizedBox(width: 12),
                                Expanded(child: Text(email, style: AppTextStyles.body)),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _NeuCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsPage()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.settings_rounded, color: AppColors.textPrimary, size: 24),
                          const SizedBox(width: 12),
                          Text('前往設定', style: AppTextStyles.bodyBold),
                          const Spacer(),
                          Icon(Icons.chevron_right, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLoggedOut(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '請先登入',
              style: AppTextStyles.h3.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            _NeuButton(
              label: '前往登入',
              onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NeuCard extends StatelessWidget {
  const _NeuCard({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
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
      child: child,
    );
    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: content,
        ),
      );
    }
    return content;
  }
}

class _NeuButton extends StatelessWidget {
  const _NeuButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.secondary,
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
          child: Text(label, style: AppTextStyles.button),
        ),
      ),
    );
  }
}
