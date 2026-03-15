import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_client.dart';

class AuthService {
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await SupabaseService.client.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await SupabaseService.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await SupabaseService.client.auth.signOut();
  }

  static User? getCurrentUser() {
    return SupabaseService.client.auth.currentUser;
  }

  static Stream<AuthState> get authStateChanges {
    return SupabaseService.client.auth.onAuthStateChange;
  }

  static Future<void> createProfile({
    required String userId,
    required String nickname,
    String? avatarUrl,
  }) async {
    try {
      await SupabaseService.client.from('profiles').insert({
        'id': userId,
        'nickname': nickname,
        if (avatarUrl != null && avatarUrl.isNotEmpty) 'avatar_url': avatarUrl,
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserProfile?> getProfile(String userId) async {
    try {
      final res = await SupabaseService.client
          .from('profiles')
          .select('nickname, avatar_url')
          .eq('id', userId)
          .maybeSingle();
      if (res == null) return null;
      return UserProfile(
        nickname: res['nickname'] as String?,
        avatarUrl: res['avatar_url'] as String?,
      );
    } catch (_) {
      return null;
    }
  }
}

class UserProfile {
  const UserProfile({this.nickname, this.avatarUrl});
  final String? nickname;
  final String? avatarUrl;
}
