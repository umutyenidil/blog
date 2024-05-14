import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/presentation/pages/login.page.dart';
import 'package:blog/features/auth/presentation/pages/register.page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkMode,
      home: const LoginPage(),
    );
  }
}
