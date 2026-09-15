class CalculatorState {
  final String display;
  final String firstOperand;
  final String operatorSymbol;
  final bool shouldResetDisplay;
  final bool unlockDashboard; // Add this

  const CalculatorState({
    this.display = '0',
    this.firstOperand = '',
    this.operatorSymbol = '',
    this.shouldResetDisplay = false,
    this.unlockDashboard = false, // Add this
  });

  CalculatorState copyWith({
    String? display,
    String? firstOperand,
    String? operatorSymbol,
    bool? shouldResetDisplay,
    bool? unlockDashboard, // Add this
  }) {
    return CalculatorState(
      display: display ?? this.display,
      firstOperand: firstOperand ?? this.firstOperand,
      operatorSymbol: operatorSymbol ?? this.operatorSymbol,
      shouldResetDisplay: shouldResetDisplay ?? this.shouldResetDisplay,
      unlockDashboard: unlockDashboard ?? this.unlockDashboard, // Add this
    );
  }
}