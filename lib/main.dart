import 'package:after_layout/after_layout.dart';
import 'package:budget_management/screens/about_screen.dart';
import 'package:budget_management/screens/add_income_screen.dart';
import 'package:budget_management/screens/add_transaction.dart';
import 'package:budget_management/screens/history_screen.dart';
import 'package:budget_management/screens/intro_screen.dart';
import 'package:budget_management/screens/new_month.dart';
import 'package:budget_management/screens/saving_screen.dart';
import 'package:budget_management/screens/tab_screen.dart';
import 'package:budget_management/screens/transaction_history_list.dart';
import 'package:budget_management/screens/transaction_list_screen.dart';
import 'package:budget_management/services/shared_prefs.dart';
import 'package:flutter/material.dart';

import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xffff7272),
        accentColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      routes: {
        HomeScreen.routeName: (cxt) => HomeScreen(),
        AddTransaction.routeName: (cxt) => AddTransaction(),
        AboutScreen.routeName: (cxt) => AboutScreen(),
        TransactionListScreen.routeName: (cxt) => TransactionListScreen(),
        AddIncome.routeName: (cxt) => AddIncome(),
        SavingScreen.routeName: (cxt) => SavingScreen(),
        TabScreen.routeName: (cxt) => TabScreen(),
        AddNewMonth.routeName: (cxt) => AddNewMonth(),
        HistoryScreen.routeName: (cxt) => HistoryScreen(),
        HistoryList.routeName: (cxt) => HistoryList()
      },
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    var userSeen = await SharedPreference().getSeen();
    if (userSeen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new TabScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          "OptiMiser",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          new Center(
            child: new Text(
              'Loading...',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
