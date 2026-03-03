import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/features/auth/login_page.dart';
import 'src/config/app_theme.dart';
import 'src/features/onboarding/onboarding_page.dart';
import 'src/layout/app_shell.dart';
import 'src/data/supabase/supabase_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file from file system (development only, not bundled in app)
  // In production builds, use --dart-define or environment variables instead
  // Example: flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    // .env file not found - will use environment variables or dart-define
    // This is expected in production builds
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SupabaseService.initialize();

  runApp(const ProviderScope(child: HawkGuardianApp()));
}

class HawkGuardianApp extends StatelessWidget {
  const HawkGuardianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hawk Guardian',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/root': (context) => const RootShell(),
      },
    );
  }
}
