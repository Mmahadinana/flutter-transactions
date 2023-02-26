import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}
/**
 *
 */
class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final entTitle =   _titleController.text;
    final entAmount = double.parse(_amountController.text);
    if ( entTitle.isEmpty || entAmount <= 0 || _selectedDate == null) {
      return;
    }
    /**
     *
     */
    widget.addNewTransaction(
        entTitle,
        entAmount,
        _selectedDate,
    );

    Navigator.of(context).pop();
  }
  
  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 5,
      child:Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitData,
              // onChanged: (val){
              //   titleInput= val;
              // },
            ),
            TextField(decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData,
              // onChanged: (val){
              //   amountInput= val;
              // },
            ),
            Container(
              height: 70,
              child: Row(
                  children: <Widget>[
                    Text(_selectedDate == null ? 'No date chosen' : 'Picked Date is ${DateFormat.yMd().format(_selectedDate)}'),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Expanded(
                        child: Text(
                          'Choose date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700]
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            ElevatedButton(
              child: Text('Add Transaction',
                style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
