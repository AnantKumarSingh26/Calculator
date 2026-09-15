import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'calculator_state.dart';

class CalculatorController extends Notifier<CalculatorState> {
  @override
  CalculatorState build() {
    return const CalculatorState(); // Initial state
  }

  void onButtonPressed(String value) {
    if (value == 'C') {
      state = const CalculatorState();
      return;
    }

    if (value == '⌫') {
      final newDisplay = state.display.length > 1 
          ? state.display.substring(0, state.display.length - 1) 
          : '0';
      state = state.copyWith(display: newDisplay);
      return;
    }

    if (value == '+' || value == '-' || value == '×' || value == '÷') {
      state = state.copyWith(
        firstOperand: state.display,
        operatorSymbol: value,
        shouldResetDisplay: true,
      );
      return;
    }

    if (value == '=') {
      // SECRET BACKDOOR TRIGGER
      if (state.display == '2580') {
        print("🚨 SECRET PIN ENTERED! 🚨");
        print("TODO: Navigate to Security Dashboard");
        state = const CalculatorState(); // Reset silently
        return;
      }

      if (state.firstOperand.isNotEmpty && state.operatorSymbol.isNotEmpty) {
        _calculateResult();
      }
      return;
    }

    // Handle numbers and decimals
    if (state.shouldResetDisplay) {
      state = state.copyWith(
        display: value,
        shouldResetDisplay: false,
      );
    } else {
      if (state.display == '0' && value != '.') {
        state = state.copyWith(display: value);
      } else {
        if (value == '.' && state.display.contains('.')) return;
        state = state.copyWith(display: state.display + value);
      }
    }
  }

  void _calculateResult() {
    double num1 = double.parse(state.firstOperand);
    double num2 = double.parse(state.display);
    double result = 0;

    switch (state.operatorSymbol) {
      case '+': result = num1 + num2; break;
      case '-': result = num1 - num2; break;
      case '×': result = num1 * num2; break;
      case '÷': result = num2 == 0 ? 0 : num1 / num2; break;
    }

    String finalDisplay = result.toString().endsWith('.0') 
        ? result.toString().substring(0, result.toString().length - 2) 
        : result.toString();
        
    state = state.copyWith(
      display: finalDisplay,
      firstOperand: '',
      operatorSymbol: '',
    );
  }
}

// This is the provider the UI will use to watch the state
final calculatorProvider = NotifierProvider<CalculatorController, CalculatorState>(() {
  return CalculatorController();
});