import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drive_worth/src/data/supabase/auth_service.dart';

final authStateProvider = StreamProvider<AuthState>((ref) {
  return AuthService.authStateChanges;
});

final currentUserProvider = Provider<User?>((ref) {
  final async = ref.watch(authStateProvider);
  return async.valueOrNull?.session?.user ?? AuthService.getCurrentUser();
});

final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  return AuthService.getProfile(user.id);
});
