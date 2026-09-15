import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'features/calculator/calculator_screen.dart';

void main() {
  // Ensure Flutter bindings are initialized before setting device orientations
  WidgetsFlutterBinding.ensureInitialized();
  // Force portrait mode (calculators look better fixed)
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
class SecureCalcApp extends StatelessWidget {
  const SecureCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF101014),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF101014),
          elevation: 0,
        )
      ),
      home: const CalculatorScreen(),
    );
  }
}
