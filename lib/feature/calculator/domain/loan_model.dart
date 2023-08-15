import 'package:hive/hive.dart';
part 'loan_model.g.dart';

@HiveType(typeId: 0)
class Loan {
  @HiveField(0)
  int term;

  @HiveField(1)
  double amount;

  @HiveField(2)
  double interestRate;

  @HiveField(3)
  String paymentType;

  @HiveField(4)
  double totalPayment;

  @HiveField(5)
  double totalInterest;

  Loan({
    required this.term,
    required this.amount,
    required this.interestRate,
    required this.paymentType,
    required this.totalPayment,
    required this.totalInterest,
  });
}