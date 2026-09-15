class CalculatorState {
  final String display;
  final String firstOperand;
  final String operatorSymbol;
  final bool shouldResetDisplay;

  const CalculatorState({
    this.display = '0',
    this.firstOperand = '',
    this.operatorSymbol = '',
    this.shouldResetDisplay = false,
  });

  // The copyWith method is crucial for immutable state management
  CalculatorState copyWith({
    String? display,
    String? firstOperand,
    String? operatorSymbol,
    bool? shouldResetDisplay,
  }) {
    return CalculatorState(
      display: display ?? this.display,
      firstOperand: firstOperand ?? this.firstOperand,
      operatorSymbol: operatorSymbol ?? this.operatorSymbol,
      shouldResetDisplay: shouldResetDisplay ?? this.shouldResetDisplay,
    );
  }
}