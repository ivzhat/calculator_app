import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../domain/loan_model.dart';

part 'calculator_event.dart';

part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorInitial()) {
    on<CalculatorCalculationStarted>((event, emit) async {
      emit(CalculatorCalculating());

      final loanAmount = double.parse(event.loanSum);
      final loanTerm = int.parse(event.loanTerm);
      final interestRate = double.parse(event.interestRate);

      double totalPayment = 0.0;
      double totalInterest = 0.0;
      final List<DataRow> dataRows = [];

      final monthlyInterestRate = interestRate / 12.0;
      double remainingBalance = loanAmount;

      if (event.selectedPaymentType == "Аннуитетный") {
        final annuityFactor =
            (monthlyInterestRate * pow(1 + monthlyInterestRate, loanTerm)) /
                (pow(1 + monthlyInterestRate, loanTerm) - 1);
        final monthlyPayment = loanAmount * annuityFactor;
        totalPayment = monthlyPayment * loanTerm;
        totalInterest = totalPayment - loanAmount;
        for (int month = 1; month <= loanTerm; month++) {
          final interest = remainingBalance * monthlyInterestRate;
          final principal = monthlyPayment - interest;
          remainingBalance -= principal;
          dataRows.add(DataRow(cells: [
            DataCell(Align(
                alignment: Alignment.center,
                child: Text(month.toStringAsFixed(0)))),
            DataCell(Align(
                alignment: Alignment.center,
                child: Text(monthlyPayment.toStringAsFixed(2)))),
            DataCell(Align(
                alignment: Alignment.center,
                child: Text(interest.toStringAsFixed(2)))),
            DataCell(Align(
                alignment: Alignment.center,
                child: Text(principal.toStringAsFixed(2)))),
            DataCell(Align(
                alignment: Alignment.center,
                child: Text(remainingBalance.toStringAsFixed(2)))),
          ]));
        }
      } else if (event.selectedPaymentType == "Дифференцированный") {
        final principal = loanAmount / loanTerm;
        for (int month = 1; month <= loanTerm; month++) {
          final interest = remainingBalance * monthlyInterestRate;
          final payment = principal + interest;
          remainingBalance -= principal;
          totalPayment += payment;
          totalInterest += interest;
          dataRows.add(DataRow(cells: [
            DataCell(Align(
                alignment: Alignment.center,
                child: Text(month.toStringAsFixed(0)))),
            DataCell(Align(
                alignment: Alignment.center,
                child: Text(payment.toStringAsFixed(2)))),
            DataCell(Align(
                alignment: Alignment.center,
                child: Text(interest.toStringAsFixed(2)))),
            DataCell(Align(
                alignment: Alignment.center,
                child: Text(principal.toStringAsFixed(2)))),
            DataCell(Align(
                alignment: Alignment.center,
                child: Text(remainingBalance.toStringAsFixed(2)))),
          ]));
        }
      }
      Loan loan = Loan(
        term: loanTerm,
        amount: loanAmount,
        interestRate: interestRate,
        paymentType: event.selectedPaymentType,
        totalPayment:  totalPayment,
        totalInterest: totalInterest,
      );
      if(!event.isFromHistory) {
        var box = await Hive.openBox<Loan>('loans');
        box.add(loan);
      }
      emit(CalculatorCalculated(loan, dataRows));
    });
  }
}
