import 'package:budget_management/screens/about_screen.dart';
import 'package:budget_management/screens/add_income_screen.dart';
import 'package:budget_management/screens/history_screen.dart';
import 'package:budget_management/screens/new_month.dart';
import 'package:budget_management/screens/saving_screen.dart';
import 'package:budget_management/screens/tab_screen.dart';
import 'package:budget_management/screens/transaction_list_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tappedPage) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.red[300],
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      onTap: tappedPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: Text(
              "Budget Explorer",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile("Home", Icons.home, () {
            Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
          }),
          buildListTile("Add Income", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(AddIncome.routeName);
          }),
          buildListTile("Your Savings", Icons.attach_money, () {
            Navigator.of(context).pushReplacementNamed(SavingScreen.routeName);
          }),
          buildListTile("Start New Month", Icons.accessibility_new, () {
            Navigator.of(context).pushReplacementNamed(AddNewMonth.routeName);
          }),
          buildListTile("Transaction List", Icons.compare_arrows, () {
            Navigator.of(context)
                .pushReplacementNamed(TransactionListScreen.routeName);
          }),
          buildListTile("Transaction History", Icons.new_releases, () {
            Navigator.of(context).pushReplacementNamed(HistoryScreen.routeName);
          }),
          buildListTile("About", Icons.question_answer, () {
            Navigator.of(context).pushReplacementNamed(AboutScreen.routeName);
          }),
        ],
      ),
    );
  }
}
