import 'dart:math';
import 'package:calculator_app/feature/calculator/ui/widget/bottom_sheet_form.dart';
import 'package:calculator_app/feature/calculator/ui/widget/payments_table.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CalculatorPage extends StatelessWidget {
  CalculatorPage({super.key});

  static const loanAmount = 100000.0;
  static const loanTerm = 12.0;
  static const interestRate = 0.12;

  double _monthlyPayment = 0.0;
  double _totalPayment = 0.0;
  double _totalInterest = 0.0;

  Map<String, double> calculateAnnuityType() {
    const monthlyInterestRate = interestRate / 12.0;
    const loanTermMonths = loanTerm;
    final annuityFactor =
        (monthlyInterestRate * pow(1 + monthlyInterestRate, loanTermMonths)) /
            (pow(1 + monthlyInterestRate, loanTermMonths) - 1);
    final monthlyPayment = loanAmount * annuityFactor;
    final totalPayment = monthlyPayment * loanTermMonths;
    final totalInterest = totalPayment - loanAmount;
    _monthlyPayment = monthlyPayment;
    _totalPayment = totalPayment;
    _totalInterest = totalInterest;
    final dataMap = {
      'Сумма кредита': _totalPayment - _totalInterest,
      'Переплата': _totalInterest,
    };
    return dataMap;
  }

  Map<String, double> calculateDifferentialType() {
    const monthlyInterestRate = interestRate / 12.0;
    const principal = loanAmount / loanTerm;
    final dataMap = <String, double>{};
    double remainingBalance = loanAmount;

    for (int month = 1; month <= loanTerm; month++) {
      final interest = remainingBalance * monthlyInterestRate;
      final payment = principal + interest;
      remainingBalance -= principal;
      dataMap['Month $month'] = payment;
    }
    return dataMap;
  }

  List<DataRow> calculateMonthlyPayment() {
    const monthlyInterestRate = interestRate / 12.0;
    const principal = loanAmount / loanTerm;
    double remainingBalance = loanAmount;

    final List<DataRow> dataRows = [];

    for (int month = 1; month <= loanTerm; month++) {
      final interest = remainingBalance * monthlyInterestRate;
      final payment = principal + interest;
      remainingBalance -= principal;
      dataRows.add(DataRow(cells: [
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(month.toStringAsFixed(0), textAlign: TextAlign.center),
        )),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(payment.toStringAsFixed(2), textAlign: TextAlign.center),
        )),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(interest.toStringAsFixed(2), textAlign: TextAlign.center),
        )),
        DataCell(Align(
          alignment: Alignment.center,
          child:
              Text(principal.toStringAsFixed(2), textAlign: TextAlign.center),
        )),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(remainingBalance.toStringAsFixed(2),
              textAlign: TextAlign.center),
        )),
      ]));
    }
    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataMap = calculateAnnuityType();
    // final Map<String, double> dataMap = calculateDifferentialType();
    final monthlyPaymentsRows = calculateMonthlyPayment();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Всего выплат',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '${_totalPayment.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Кредитная ставка',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '${(interestRate*100).toStringAsFixed(2)} %',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Переплата',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '${_totalInterest.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: PaymentsTable(dataRows: monthlyPaymentsRows),
          ),
          PieChart(
            dataMap: dataMap,
            chartRadius: MediaQuery.of(context).size.width / 2.0,
            chartType: ChartType.disc,
            colorList: [
              Colors.blue,
              Colors.green,
            ],
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.bottom,
              showLegends: true,
              legendTextStyle: TextStyle(fontSize: 18.0),
            ),
            chartValuesOptions: ChartValuesOptions(
              chartValueBackgroundColor: Colors.transparent,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 2,
              chartValueStyle: TextStyle(color: Colors.white),
            ),
          ),
          BottomSheetForm(),
        ]
      ),
    );
  }
}
