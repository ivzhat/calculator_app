import 'package:calculator_app/feature/calculator/ui/widget/bottom_sheet_form.dart';
import 'package:calculator_app/feature/calculator/ui/widget/payments_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import '../bloc/calculator_bloc.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        if(state is CalculatorInitial) {
          return Center(
            child: BottomSheetForm()
          );
        } else if(state is CalculatorCalculating) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if(state is CalculatorCalculated) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                                state.loan.totalPayment.toStringAsFixed(2),
                                style: const TextStyle(
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
                                '${(state.loan.interestRate * 100).toStringAsFixed(2)} %',
                                style: const TextStyle(
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
                                state.loan.totalInterest.toStringAsFixed(2),
                                style: const TextStyle(
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
                  const SizedBox(height: 10.0),
                  PieChart(
                    dataMap: {
                      'Сумма кредита': state.loan.amount,
                      'Переплата': state.loan.totalInterest
                    },
                    chartRadius: MediaQuery.of(context).size.width / 2.0,
                    chartType: ChartType.disc,
                    colorList: const [
                      Colors.blue,
                      Colors.green,
                    ],
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.bottom,
                      showLegends: true,
                      legendTextStyle: TextStyle(fontSize: 18.0),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      chartValueBackgroundColor: Colors.transparent,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 2,
                      chartValueStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width),
                    child: PaymentsTable(dataRows: state.dataRows),
                    // child: PaymentsTable(dataRows: monthlyPaymentsRows),
                  ),
                  const SizedBox(height: 10.0),
                  BottomSheetForm(),
                  const SizedBox(height: 10.0),
                ]),
          );
        } else {
          return Center(
            child: Container(),
          );
        }
      },
    );
  }
}
