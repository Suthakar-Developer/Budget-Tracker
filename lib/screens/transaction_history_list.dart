import 'package:budget_management/model/transaction.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatefulWidget {
  static const routeName = "transaction_history_screen";
  final String transaction;
  HistoryList({this.transaction});
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  List<Transaction> listOfTransactions = [];

  @override
  void initState() {
    _loadInitial();
    super.initState();
  }

  _loadInitial() {
    final List<Transaction> decodedData =
        Transaction.decodeTransactions(widget.transaction);
    setState(() {
      if (widget.transaction != "[]") {
        listOfTransactions = decodedData;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          "Transactions",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
      ),
      body: listOfTransactions.length == 0
          ? Center(child: Text("No transactions made this month."))
          : Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Center(
                    child: Card(
                  color: Colors.amber,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Transactions",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 4,
                        ),
                        bottom: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: ListView.builder(
                      itemBuilder: (cxt, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  color: Colors.green,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                          "Rs ${listOfTransactions[index].amount}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                          maxLines: 1),
                                    ),
                                  ),
                                )),
                            title: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${listOfTransactions[index].title}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${listOfTransactions[index].category}  ${listOfTransactions[index].date.substring(0, 11)}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                            ),
                          ),
                        ),
                      ),
                      itemCount: listOfTransactions.length,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
