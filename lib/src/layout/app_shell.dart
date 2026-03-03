import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../features/home/home_page.dart';
import 'app_drawer.dart';

class RootShell extends StatelessWidget {
  const RootShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBackground,
      body: const HomePage(),
      drawer: const Drawer(child: AppDrawer()),
    );
  }
}
