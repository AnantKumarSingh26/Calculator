import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Add this
import 'features/calculator/calculator_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Wrap the app in ProviderScope
  runApp(const ProviderScope(child: SecureCalcApp()));
}

class SecureCalcApp extends StatelessWidget {
  const SecureCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureCalc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF101014),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF101014),
          elevation: 0,
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}