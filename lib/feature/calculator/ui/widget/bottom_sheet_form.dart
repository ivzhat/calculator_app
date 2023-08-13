import 'package:calculator_app/feature/calculator/bloc/calculator_bloc.dart';
import 'package:calculator_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetForm extends StatelessWidget {
  BottomSheetForm({super.key});

  final TextEditingController _sumController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _termController = TextEditingController();
  String selectedPaymentType = 'Аннуитетный';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Перерасчитать платежи'),
        onPressed: () {
          showModalBottomSheet<void>(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) {
                  if (state is CalculatorCalculated) {
                    _termController.text = state.loanTerm.toString();
                    _interestController.text = state.interestRate.toString();
                    _sumController.text = state.loanAmount.toString();
                    selectedPaymentType = state.typeOfPayment;
                  }
                  return StatefulBuilder(builder: (context, setState) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0))),
                      padding: const EdgeInsets.all(25.0),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Сумма кредита:',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _sumController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Процентная ставка:',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _interestController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Срок кредита:',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _termController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: 50,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.5,
                                    backgroundColor:
                                      selectedPaymentType == 'Аннуитетный'
                                            ? Colors.blue
                                            : const Color(0xFFEEEEEE),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedPaymentType = 'Аннуитетный';
                                    });
                                  },
                                  child: Text(
                                    'Аннуитетный',
                                    style: TextStyle(
                                      color: selectedPaymentType ==
                                                'Аннуитетный'
                                            ? Colors.white
                                            : Colors.black54),
                                  )
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.5,
                                    backgroundColor: selectedPaymentType ==
                                            'Дифференцированный'
                                        ? Colors.blue
                                        : const Color(0xFFEEEEEE),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedPaymentType =
                                          'Дифференцированный';
                                    });
                                  },
                                  child: Text(
                                    'Дифференцированный',
                                    style: TextStyle(
                                      color: selectedPaymentType ==
                                                'Дифференцированный'
                                            ? Colors.white
                                            : Colors.black54),
                                  )
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(50.0, 50.0),
                              elevation: 0.5,
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<CalculatorBloc>(context)
                                  .add(CalculatorCalculationStarted(
                                _sumController.text,
                                _interestController.text,
                                _termController.text,
                                selectedPaymentType,
                              ));
                              appRouter.pop();
                            },
                            child: const Text(
                              'Рассчитать платежи',
                              style: TextStyle(color: Colors.white),
                            )
                          ),
                        ],
                      ),
                    );
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}