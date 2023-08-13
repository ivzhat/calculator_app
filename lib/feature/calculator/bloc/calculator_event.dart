part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class CalculatorCalculationStarted extends CalculatorEvent {
  CalculatorCalculationStarted(this.loanSum, this.interestRate, this.loanTerm, this.selectedPaymentType);

  final String loanSum;
  final String interestRate;
  final String loanTerm;
  final String selectedPaymentType;
}
