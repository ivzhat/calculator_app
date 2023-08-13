import 'package:flutter/material.dart';

class PaymentsTable extends StatelessWidget {
  const PaymentsTable({super.key, required this.dataRows});

  final List<DataRow> dataRows;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      showBottomBorder: true,
      columns: [
        DataColumn(label: Text(' №', style: TextStyle(fontSize: 16.0))),
        DataColumn(label: Text('Платеж', style: TextStyle(fontSize: 16.0))),
        DataColumn(label: Text('Проценты', style: TextStyle(fontSize: 16.0))),
        DataColumn(label: Text('Тело кредита', style: TextStyle(fontSize: 16.0), maxLines: 2)),
        DataColumn(label: Text('Остаток', style: TextStyle(fontSize: 16.0))),
      ],
      rows: dataRows,
      dividerThickness: 1,
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
      columnSpacing: 5.0,
      horizontalMargin: 0.0,
    );
  }
}