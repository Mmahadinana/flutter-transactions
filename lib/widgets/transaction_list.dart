import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget{
  final Function deleteTransaction;
  final List<Transaction> transactions;

  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context){
    return transactions.isEmpty ? LayoutBuilder(
        builder: (cxt, constraints) {
      return Column(
        children: <Widget>[
          Text('No transactions added yet', style: Theme.of(context).textTheme.titleMedium,),
          SizedBox(
            height: 30,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset('assets/image/waiting.png', fit:BoxFit.cover),
          )

        ],
      );
    })  : ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding:EdgeInsets.symmetric(vertical: 6,horizontal: 3),
                    child: FittedBox(
                    child: Text('\$${transactions[index].amount}'),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
                trailing: IconButton( onPressed: () => deleteTransaction(transactions[index].id),icon: Icon(Icons.delete), color: Theme.of(context).errorColor,) ,
              ), 
            );
          },
        itemCount: transactions.length,
    );
  }
}