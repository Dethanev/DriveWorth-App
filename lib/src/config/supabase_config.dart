import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  /// Get Supabase URL from environment variables, dart-define, or .env file
  static String get url {
    // Priority 1: dart-define (--dart-define=SUPABASE_URL=...)
    final dartDefineUrl = const String.fromEnvironment('SUPABASE_URL');
    if (dartDefineUrl.isNotEmpty) {
      return dartDefineUrl;
    }

    // Priority 2: System environment variable
    final envUrl = Platform.environment['SUPABASE_URL'];
    if (envUrl != null && envUrl.isNotEmpty) {
      return envUrl;
    }

    // Priority 3: .env file (development only, not bundled in production)
    try {
      final dotenvUrl = dotenv.env['SUPABASE_URL'];
      if (dotenvUrl != null && dotenvUrl.isNotEmpty) {
        return dotenvUrl;
      }
    } catch (e) {
      // dotenv not initialized, skip
    }

    throw Exception(
      'SUPABASE_URL is not set. Use --dart-define=SUPABASE_URL=... or set environment variable.',
    );
  }

  /// Get Supabase anon key from environment variables, dart-define, or .env file
  static String get anonKey {
    // Priority 1: dart-define (--dart-define=SUPABASE_ANON_KEY=...)
    final dartDefineKey = const String.fromEnvironment('SUPABASE_ANON_KEY');
    if (dartDefineKey.isNotEmpty) {
      return dartDefineKey;
    }

    // Priority 2: System environment variable
    final envKey = Platform.environment['SUPABASE_ANON_KEY'];
    if (envKey != null && envKey.isNotEmpty) {
      return envKey;
    }

    // Priority 3: .env file (development only, not bundled in production)
    try {
      final dotenvKey = dotenv.env['SUPABASE_ANON_KEY'];
      if (dotenvKey != null && dotenvKey.isNotEmpty) {
        return dotenvKey;
      }
    } catch (e) {
      // dotenv not initialized, skip
    }

    throw Exception(
      'SUPABASE_ANON_KEY is not set. Use --dart-define=SUPABASE_ANON_KEY=... or set environment variable.',
    );
  }
}
