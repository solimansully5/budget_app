import 'package:flutter/cupertino.dart';
class Transaction {
  final DateTime date;
  final String id;
  final String title;
  final double amount;

  Transaction({@required this.id,@required this.date,@required this.amount,@required this.title});
}