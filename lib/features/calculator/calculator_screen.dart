import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'calculator_controller.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calcState = ref.watch(calculatorProvider);
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Updated Display Area
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Shows the previous number and operator (e.g., "23 -")
                    if (calcState.operatorSymbol.isNotEmpty)
                      Text(
                        '${calcState.firstOperand} ${calcState.operatorSymbol}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: Colors.white54, // Faded text
                        ),
                      ),
                    const SizedBox(height: 8),
                    // Main display wrapped in a horizontal scroll view
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true, // Auto-scrolls to the right as you type
                      child: Text(
                        calcState.display,
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Keypad Area (Remains unchanged)
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF15151A),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(ref, 'C', textColor: Colors.redAccent),
                          _buildButton(ref, '⌫', textColor: Colors.orangeAccent),
                          _buildButton(ref, '%', textColor: Colors.tealAccent),
                          _buildButton(ref, '÷', textColor: Colors.tealAccent),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(ref, '7'),
                          _buildButton(ref, '8'),
                          _buildButton(ref, '9'),
                          _buildButton(ref, '×', textColor: Colors.tealAccent),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(ref, '4'),
                          _buildButton(ref, '5'),
                          _buildButton(ref, '6'),
                          _buildButton(ref, '-', textColor: Colors.tealAccent),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(ref, '1'),
                          _buildButton(ref, '2'),
                          _buildButton(ref, '3'),
                          _buildButton(ref, '+', textColor: Colors.tealAccent),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(ref, '0'),
                          _buildButton(ref, '.'),
                          _buildButton(ref, '=', color: Colors.tealAccent, textColor: Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(WidgetRef ref, String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            ref.read(calculatorProvider.notifier).onButtonPressed(text);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: color ?? const Color(0xFF1E1E24),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                )
              ],
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}