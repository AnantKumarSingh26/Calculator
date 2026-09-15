import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'calculator_state.dart';
import '../logs/log_model.dart';
import '../../services/database_service.dart';

class CalculatorController extends Notifier<CalculatorState> {
  // We'll store a reference to the DB service
  late final DatabaseService _dbService;

  @override
  CalculatorState build() {
    // Grab the database service from the Riverpod provider
    _dbService = ref.read(databaseProvider);
    return const CalculatorState();
  }

  void onButtonPressed(String value) {
    // 1. Log the event to SQLite silently in the background
    _logAction(value);

    // ... (Keep the rest of your exact same button logic here)
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

    // Replace your secret backdoor trigger inside onButtonPressed with this:
    if (value == '=') {
      if (state.display == '2580') {
        // Trigger the UI to navigate, and wipe the display
        state = const CalculatorState(unlockDashboard: true);
        return;
      }

      if (state.firstOperand.isNotEmpty && state.operatorSymbol.isNotEmpty) {
        _calculateResult();
      }
      return;
    }

    if (state.shouldResetDisplay) {
      state = state.copyWith(display: value, shouldResetDisplay: false);
    } else {
      if (state.display == '0' && value != '.') {
        state = state.copyWith(display: value);
      } else {
        if (value == '.' && state.display.contains('.')) return;
        state = state.copyWith(display: state.display + value);
      }
    }
  }

  // New method to handle the database insertion
  Future<void> _logAction(String buttonPressed) async {
    final log = LogEvent(
      eventType: 'calculator_input',
      description: buttonPressed,
      timestamp: DateTime.now(),
      source: 'Flutter',
    );

    // This runs asynchronously so it doesn't slow down the UI
    await _dbService.insertLog(log);
  }

  void _calculateResult() {
    // ... (keep your existing _calculateResult logic here)
    double num1 = double.parse(state.firstOperand);
    double num2 = double.parse(state.display);
    double result = 0;

    switch (state.operatorSymbol) {
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
        result = num2 == 0 ? 0 : num1 / num2;
        break;
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

  // Call this after navigation happens so it doesn't get stuck in a loop
  void resetNavigationFlag() {
    state = state.copyWith(unlockDashboard: false);
  }
}

final calculatorProvider =
    NotifierProvider<CalculatorController, CalculatorState>(() {
      return CalculatorController();
    });
