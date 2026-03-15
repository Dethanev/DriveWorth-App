import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/features/auth/auth_gate.dart';
import 'src/features/auth/login_page.dart';
import 'src/config/app_theme.dart';
import 'src/features/onboarding/onboarding_page.dart';
import 'src/layout/app_shell.dart';
import 'src/data/supabase/supabase_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    await dotenv.load(fileName: '.env');
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SupabaseService.initialize();

  runApp(const ProviderScope(child: DriveWorthApp()));
}

class DriveWorthApp extends StatelessWidget {
  const DriveWorthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drive Worth',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/root': (context) => const RootShell(),
      },
    );
  }
}
