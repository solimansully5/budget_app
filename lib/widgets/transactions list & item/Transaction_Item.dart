import 'dart:math';

import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.userTransac,
    @required this.removeTx,
  }) : super(key: key);

  final Transaction userTransac;
  final Function removeTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.purple,
      Colors.blue,
      Colors.brown,
    ];
    _bgColor=availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Card(
        elevation: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: _bgColor,
                  border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor)),
              margin: EdgeInsets.all(10),
              child: FittedBox(
                child: Text(
                  '\$ ${widget.userTransac.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.userTransac.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                Text(
                  DateFormat.yMd().add_jm().format(widget.userTransac.date),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            MediaQuery.of(context).size.width > 460
                ? TextButton.icon(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => widget.removeTx(widget.userTransac.id),
                    label: const Text(
                      'Delete',
                    ))
                : IconButton(
                    onPressed: () => widget.removeTx(widget.userTransac.id),
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                  )
          ],
        ),
      );
    });
  }
}
