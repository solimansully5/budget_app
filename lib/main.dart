import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import './widgets/transactions list & item/transaction_list.dart';
import './widgets/Chart & ChartBar/charts.dart';
import './models/transaction.dart';
import './widgets/add_transaction/New_Transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        secondaryHeaderColor: Colors.blue,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'openSans'),
        ),
        // appBarTheme: AppBarTheme(
        //   textTheme: ThemeData.light().textTheme.copyWith(
        //     title: TextStyle(
        //       fontFamily: 'OpenSans',
        //       fontSize: 50,
        //       fontWeight: FontWeight.bold
        //     ),
        //   ),
        // ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    //super.didChangeAppLifecycleState(state);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final List<Transaction> _transactions = [
    // Transaction(
    //     id: 'soma0', date: DateTime.now(), amount: 75, title: 'new shoes'),
    // Transaction(
    //     id: 'soma1', date: DateTime.now(), amount: 20, title: 'new hat'),
  ];

  void _addNewTransaction(double aamount, String ttitle, DateTime datte) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        date: datte,
        amount: aamount,
        title: ttitle);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTrans(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return NewTransaction(
            addnewtx: _addNewTransaction,
          );
        });
  }

  List<Transaction> get _recentTx {
    return _transactions.where((elem) {
      return elem.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _removeTrans(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  bool _showChart = false;

  List<Widget> _buildLandScapeContent({AppBar appBar,Widget txListWidget}) {
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Show Chart'),
        Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            }),
      ],
    ),  _showChart
        ? Container(
        height: (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
            0.7,
        child: Chart(recentTrans: _recentTx))
        : txListWidget,];
  }
  
  List<Widget> _buildPortraitContent({AppBar appBar,Widget txListWidget}){
    return [Container(
        height: (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
            0.3,
        child: Chart(recentTrans: _recentTx)),txListWidget,];
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      actions: [
        IconButton(
            onPressed: () => _startAddNewTrans(context),
            icon: Icon(Icons.add, color: Theme.of(context).canvasColor),
            color: Theme.of(context).secondaryHeaderColor),
      ],
      centerTitle: true,
      title: Text(
        'Budget App', //style: TextStyle(fontFamily: 'Quicksand'),
      ),
    );

    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(
            userTransac: _transactions, removeTx: _removeTrans));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (isLandScape) ..._buildLandScapeContent(appBar: appBar,txListWidget: txListWidget),
              if (!isLandScape) ..._buildPortraitContent(appBar: appBar,txListWidget: txListWidget),
            //  SizedBox(height: 20,),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _startAddNewTrans(context),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
