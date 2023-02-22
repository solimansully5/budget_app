import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transaction.dart';
import '../transactions list & item/Transaction_Item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransac;
  final Function removeTx;
  TransactionList({this.userTransac, this.removeTx});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return userTransac.isEmpty
          ? Column(
              children: [
                Text(
                  'no transaction yet!',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'myImages/waiting.png',
                      fit: BoxFit.fitHeight,
                    ))
              ],
            )
          : ListView(
              children: userTransac
                  .map((tx) => TransactionItem(key: ValueKey(tx.id),userTransac: tx, removeTx: removeTx))
                  .toList(),
            );
    });
  }
}
