import 'package:flutter/material.dart';

class Loan {
  final int term;
  final double amount;
  final double interestRate;
  final String paymentType;
  final double totalPayment;
  final double totalInterest;

  final List<DataRow> dataRows;

  Loan({
    required this.term,
    required this.amount,
    required this.interestRate,
    required this.paymentType,
    required this.totalPayment,
    required this.totalInterest,
    required this.dataRows,
  });
}