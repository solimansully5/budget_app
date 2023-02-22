import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addnewtx;
  NewTransaction({this.addnewtx}) {
    print("Constructor NewTransaction Widget");
  }

  @override
  State<NewTransaction> createState() {
    print('createstate newtransaction widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  _NewTransactionState() {
    print("constructor newtransaction state widget");
  }

  @override
  void initState() {
    super.initState();
    print('print initstate');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('print didupdatewidget');
  }

  @override
  void dispose() {
    super.dispose();
    print('print dispose');
  }

  final _titleController = TextEditingController();
  DateTime _userDate;
  final _amountController = TextEditingController();

  void _sumbitData() {
    final enteredAmount = double.parse(_amountController.text);
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _userDate == null) {
      return;
    }
    widget.addnewtx(enteredAmount, enteredTitle, _userDate);
    Navigator.of(context).pop();
  }

  void _presrntDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _userDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _sumbitData(),
                // onChanged: (val){
                //   titleInput=val;
                // },
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onSubmitted: (_) => _sumbitData(),
                keyboardType: TextInputType.number,
                controller: _amountController,
                //   onChanged: (value){
                //   amountInput=value;
                // },
                decoration: InputDecoration(labelText: 'amount'),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(_userDate == null
                      ? 'No Date Chosen Yet!'
                      : 'Picked Date : ${DateFormat.yMd().format(_userDate)}'),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: _presrntDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: _sumbitData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
