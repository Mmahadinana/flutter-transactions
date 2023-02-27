import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       title: 'Rosy App',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          backgroundColor: Colors.amber,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 36,
                  fontWeight: FontWeight.bold
            ),
          )
        ),
        home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
  // String titleInput = "";
  // String amountInput = "";
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();
class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1',
        title: 'Banana',
        amount: 19.99,
        date: DateTime.now().subtract(Duration(days:3))
    ),Transaction(
        id: 't2',
        title: 'Apple',
        amount: 824.99,
        date: DateTime.now().subtract(Duration(days:1))
    ),Transaction(
        id: 't3',
        title: 'Peach',
        amount: 724.99,
        date: DateTime.now().subtract(Duration(days:3))
    ),Transaction(
        id: 't4',
        title: 'Grapes',
        amount: 3324.99,
        date: DateTime.now().subtract(Duration(days:2))
    ),Transaction(
        id: 't5',
        title: 'Barries',
        amount: 24.99,
        date: DateTime.now().subtract(Duration(days:1))
    ),
  ];

  bool _showChart = false;
  List<Transaction> get _recentTractions {
    return _userTransactions.where((txt){
        return txt.date.isAfter(
            DateTime.now().subtract(
                Duration(days: 7),
            ),
        );
    }).toList();
  }

  void _addNewTransaction (String txTitle, double txtAmount, DateTime txtDate) {
    final newTxt = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txtAmount,
        date: txtDate);

    setState(() {
      _userTransactions.add(newTxt);
    });
  }
  void _startAtNewTransaction(BuildContext cxt) {
    showModalBottomSheet(
        context: cxt,
        builder: (_) {
             return GestureDetector(
               onTap: () {},
               child: NewTransaction(_addNewTransaction),
             ) ;
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape = MediaQuery.of(context).orientation == Orientation;
    final appBar =  AppBar(
      title: Text('Rosy App'),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAtNewTransaction(context),
        )
      ],
    );

    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
          appBar.preferredSize.height -
          MediaQuery.of(context).padding.top) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if(isLandScape) Row(
                    mainAxisAlignment:MainAxisAlignment.center ,
                    children: <Widget> [
                      Text('Show Chard'),
                      Switch(value: true, onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      }),
                ]),
               if (!isLandScape)  Container(
                 height: (MediaQuery.of(context).size.height -
                     appBar.preferredSize.height -
                     MediaQuery.of(context).padding.top) * 0.3,
                 child: Chart(_recentTractions),
               ),
                if (!isLandScape) txListWidget,
                if (isLandScape) _showChart ?  Container(
                  height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) * 0.3,
                  child: Chart(_recentTractions),
                ) : txListWidget,
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () =>_startAtNewTransaction(context),
          ),
    );
  }
}
