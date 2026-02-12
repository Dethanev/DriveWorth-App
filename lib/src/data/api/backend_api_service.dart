import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../supabase/supabase_client.dart';

class BackendApiService {
  // 從 .env 獲取後端 URL，如果沒有則使用預設值
  static String get baseUrl {
    final url = dotenv.env['BACKEND_URL'];
    return url ?? 'http://localhost:8000';
  }

  // 獲取認證 headers
  static Future<Map<String, String>> _getAuthHeaders() async {
    final session = SupabaseService.client.auth.currentSession;

    if (session == null) {
      throw Exception('使用者未登入');
    }

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${session.accessToken}',
    };
  }

  // 驗證 token
  static Future<bool> verifyToken() async {
    try {
      final session = SupabaseService.client.auth.currentSession;
      if (session == null) return false;

      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/verify'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': session.accessToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['valid'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // 獲取當前使用者資訊（從後端，包含 profiles 資料）
  static Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/api/auth/me'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('認證失敗，請重新登入');
      } else {
        throw Exception('獲取使用者資訊失敗: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // 更新使用者 profile
  static Future<Map<String, dynamic>> updateProfile({
    String? nickname,
    String? avatarUrl,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final body = <String, dynamic>{};
      if (nickname != null) body['nickname'] = nickname;
      if (avatarUrl != null) body['avatar_url'] = avatarUrl;

      final response = await http.put(
        Uri.parse('$baseUrl/api/auth/profile'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('認證失敗，請重新登入');
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['detail'] ?? '更新失敗: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
