import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _firstOperand = '';
  String _operator = '';
  bool _shouldResetDisplay = false;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _firstOperand = '';
        _operator = '';
        return;
      }

      if (value == '⌫') {
        if (_display.length > 1) {
          _display = _display.substring(0, _display.length - 1);
        } else {
          _display = '0';
        }
        return;
      }

      if (value == '+' || value == '-' || value == '×' || value == '÷') {
        _firstOperand = _display;
        _operator = value;
        _shouldResetDisplay = true;
        return;
      }

      if (value == '=') {
        // SECRET BACKDOOR TRIGGER
        if (_display == '2580') {
          print("🚨 SECRET PIN ENTERED! 🚨");
          print("TODO: Navigate to Security Dashboard");
          _display = '0'; // reset so it doesn't stay on screen
          return;
        }

        if (_firstOperand.isNotEmpty && _operator.isNotEmpty) {
          _calculateResult();
        }
        return;
      }

      // Handle number and decimal inputs
      if (_shouldResetDisplay) {
        _display = value;
        _shouldResetDisplay = false;
      } else {
        if (_display == '0' && value != '.') {
          _display = value;
        } else {
          if (value == '.' && _display.contains('.')) return; // Prevent multiple decimals
          _display += value;
        }
      }
    });
  }

  void _calculateResult() {
    double num1 = double.parse(_firstOperand);
    double num2 = double.parse(_display);
    double result = 0;

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '×':
        result = num1 * num2;
        break;
      case '÷':
        result = num2 == 0 ? 0 : num1 / num2; // basic divide by zero protection
        break;
    }

    // Remove decimal if it's a whole number (e.g., 5.0 -> 5)
    _display = result.toString().endsWith('.0') 
        ? result.toString().substring(0, result.toString().length - 2) 
        : result.toString();
        
    _firstOperand = '';
    _operator = '';
  }

  Widget _buildButton(String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => _onButtonPressed(text),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(32),
                child: Text(
                  _display,
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            
            // Keypad Area
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
                          _buildButton('C', textColor: Colors.redAccent),
                          _buildButton('⌫', textColor: Colors.orangeAccent),
                          _buildButton('%', textColor: Colors.tealAccent),
                          _buildButton('÷', textColor: Colors.tealAccent),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('7'),
                          _buildButton('8'),
                          _buildButton('9'),
                          _buildButton('×', textColor: Colors.tealAccent),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('4'),
                          _buildButton('5'),
                          _buildButton('6'),
                          _buildButton('-', textColor: Colors.tealAccent),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('1'),
                          _buildButton('2'),
                          _buildButton('3'),
                          _buildButton('+', textColor: Colors.tealAccent),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('0'),
                          _buildButton('.'),
                          _buildButton('=', color: Colors.tealAccent, textColor: Colors.black),
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
}