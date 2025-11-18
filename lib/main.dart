import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: CleanifyApp()));
}

class CleanifyApp extends StatelessWidget {
  const CleanifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cleanify App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF84A9BB)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
