part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorCalculating extends CalculatorState {}

class CalculatorCalculated extends CalculatorState {
  CalculatorCalculated(this.loan);

  final Loan loan;
}
