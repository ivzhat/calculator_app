import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../routes.dart';
import '../bloc/calculator_bloc.dart';
import '../domain/loan_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Loan>('loans').listenable(),
      builder: (context, Box<Loan> box, _) {
        if (box.length == 0) {
          return const Center(child: Text('История пуста'));
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: box.length,
            itemBuilder: (context, index) {
              Loan loan = box.getAt(index)!;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ListTile(
                  title: Text('Займ № ${index + 1}'),
                  subtitle: Text(
                    'Сумма: ${loan.amount}, Кредитная ставка: ${loan.interestRate}, Срок: ${loan.term}, Тип платежа: ${loan.paymentType}',
                    softWrap: true,
                    maxLines: 2,
                  ),
                  onTap: () {
                    BlocProvider.of<CalculatorBloc>(context)
                        .add(CalculatorCalculationStarted(
                      loan.amount.toString(),
                      loan.interestRate.toString(),
                      loan.term.toString(),
                      loan.paymentType,
                      isFromHistory: true,
                    ));
                    appRouter.go('/');
                  },
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            content: TextButton(
                                onPressed: () {
                                  appRouter.pop();
                                  box.deleteAt(index);
                                },
                                child: const Text(
                                  'Удалить запись из истории',
                                  style: TextStyle(color: Colors.black54),
                                )),
                          );
                        });
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
