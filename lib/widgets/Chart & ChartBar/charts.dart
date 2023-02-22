import 'package:flutter/material.dart';
import '../Chart & ChartBar/ChartBars.dart';
import '../../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTrans;
  Chart({this.recentTrans});
  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (int i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == weekday.day &&
            recentTrans[i].date.month == weekday.month &&
            recentTrans[i].date.year == weekday.year) {
          totalSum += recentTrans[i].amount;
        }
      }
      // print(DateFormat.E().format(weekday));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpent {
    return groupedTransaction.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((e) {
            return Expanded(
              child: ChartBar(
                label: e['day'],
                spendingAmount: e['amount'] ,
                spendingPctOfTotal:totalSpent ==0.0 ? 0.0 : (e['amount'] as double) / totalSpent,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
