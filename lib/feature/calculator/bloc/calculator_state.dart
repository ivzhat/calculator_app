part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorCalculating extends CalculatorState {}

class CalculatorCalculated extends CalculatorState {
  CalculatorCalculated(this.dataRows, this.totalPayment, this.totalInterest, this.interestRate, this.loanAmount, this.loanTerm, this.typeOfPayment);

  final List<DataRow> dataRows;
  final double totalPayment;
  final double totalInterest;
  final double interestRate;
  final double loanAmount;
  final int loanTerm;
  final String typeOfPayment;
}
