import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

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
                fontSize: 30,
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
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Rosy App'),
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startAtNewTransaction(context),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Chart(_recentTractions),
                TransactionList(_userTransactions, _deleteTransaction),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () =>_startAtNewTransaction(context),
          ),
        )
    );
  }
}
