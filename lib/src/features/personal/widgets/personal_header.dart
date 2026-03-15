import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drive_worth/src/config/app_colors.dart';
import 'package:drive_worth/src/data/supabase/auth_service.dart';
import 'package:drive_worth/src/features/auth/providers/auth_state_provider.dart';

class Header extends ConsumerWidget {
  const Header({super.key});

  static String _displayName(User? user, UserProfile? profile) {
    if (profile?.nickname != null && profile!.nickname!.isNotEmpty) return profile.nickname!;
    final email = user?.email;
    if (email != null && email.isNotEmpty) return email.split('@').first;
    return '使用者';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profileAsync = ref.watch(userProfileProvider);
    final profile = profileAsync.valueOrNull;
    final displayName = _displayName(user, profile);
    final email = user?.email ?? '';
    final ImageProvider avatarImage = (profile?.avatarUrl != null && profile!.avatarUrl!.isNotEmpty)
        ? NetworkImage(profile.avatarUrl!)
        : const AssetImage('assets/images/Ethan.png');

    return UserAccountsDrawerHeader(
      accountName: Text(displayName, style: const TextStyle(color: AppColors.white)),
      accountEmail: Text(email, style: const TextStyle(color: AppColors.white)),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: avatarImage,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/app_icon.png'),
        ),
      ),
    );
  }
}
