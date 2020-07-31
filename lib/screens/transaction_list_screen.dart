import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budget_management/model/transaction.dart';
import 'package:budget_management/services/shared_prefs.dart';
import 'package:budget_management/widgets/main_drawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class TransactionListScreen extends StatefulWidget {
  static const routeName = "transaction_screen";
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  List<Transaction> listOfTransactions = [];
  double medi, groc, educ, dailn, fest, othe, homea, debts;

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    super.initState();

    _loadInitial();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadInitial();
  }

  _loadInitial() async {
    var initTransaction = await SharedPreference().getTransactions();
    var medical = await SharedPreference().getMedicals();
    var grocery = await SharedPreference().getGroceries();
    var education = await SharedPreference().getEducation();
    var dailyneeds = await SharedPreference().getDailyneeds();
    var festivals = await SharedPreference().getFestivals();
    var debt = await SharedPreference().getDebt();
    var homeapps = await SharedPreference().getHomeapps();
    var others = await SharedPreference().getOthers();
    final List<Transaction> decodedData =
        Transaction.decodeTransactions(initTransaction);
    setState(() {
      medi = double.parse(medical);
      groc = double.parse(grocery);
      educ = double.parse(education);
      dailn = double.parse(dailyneeds);
      fest = double.parse(festivals);
      debts = double.parse(debt);
      homea = double.parse(homeapps);
      othe = double.parse(others);
      if (initTransaction != "[]") {
        listOfTransactions = decodedData;
      }
    });
  }

  _setTransactions(String transactionDetails) async {
    final bool result =
        await SharedPreference().setTransactions(transactionDetails);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  _setMedicals(String medical) async {
    final bool result = await SharedPreference().setMedical(medical);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  _setGroceries(String grocery) async {
    final bool result = await SharedPreference().setGroceries(grocery);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  _setEducation(String educ) async {
    final bool result = await SharedPreference().setEducation(educ);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  _setDailyneeds(String dn) async {
    final bool result = await SharedPreference().setDailyneeds(dn);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  _setHomeapps(String home) async {
    final bool result = await SharedPreference().setHomeapps(home);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  _setDebts(String debt) async {
    final bool result = await SharedPreference().setDebt(debt);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  _setFestivals(String fest) async {
    final bool result = await SharedPreference().setFestivals(fest);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  _setOthers(String other) async {
    final bool result = await SharedPreference().setOther(other);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  void deleteTransaction(String id) async {
    final Transaction transToBeDeleted =
        listOfTransactions.firstWhere((element) => element.id == id);
    final double undoTransAmount = transToBeDeleted.amount;
    var userIncome = await SharedPreference().getIncome();
    if (transToBeDeleted.category == "Medical") {
      final double catAmnt = medi - undoTransAmount;
      _setMedicals(catAmnt.toString());
    } else if (transToBeDeleted.category == "Grocery") {
      final double catAmnt = groc - undoTransAmount;
      _setGroceries(catAmnt.toString());
    } else if (transToBeDeleted.category == "Education") {
      final double catAmnt = educ - undoTransAmount;
      _setEducation(catAmnt.toString());
    } else if (transToBeDeleted.category == "Daily Needs") {
      final double catAmnt = dailn - undoTransAmount;
      _setDailyneeds(catAmnt.toString());
    } else if (transToBeDeleted.category == "Festival") {
      final double catAmnt = fest - undoTransAmount;
      _setFestivals(catAmnt.toString());
    } else if (transToBeDeleted.category == "Home Appliances") {
      final double catAmnt = homea - undoTransAmount;
      _setHomeapps(catAmnt.toString());
    } else if (transToBeDeleted.category == "Debt/EMI") {
      final double catAmnt = debts - undoTransAmount;
      _setDebts(catAmnt.toString());
    } else if (transToBeDeleted.category == "Others") {
      final double catAmnt = othe - undoTransAmount;
      _setOthers(catAmnt.toString());
    }
    final double _userIncome = userIncome;
    final double updatedIncome = _userIncome + undoTransAmount;
    _setIncome(updatedIncome);
    listOfTransactions.removeWhere((prod) => prod.id == id);
    final String encodedData =
        Transaction.encodeTransactions(listOfTransactions);
    _setTransactions(encodedData);
  }

  _setIncome(double income) async {
    final bool result = await SharedPreference().setIncome(income);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          "Transaction List",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    )),
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.56,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Marquee(
                      text: 'List of Transactions',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 20.0,
                      velocity: 40.0,
                      pauseAfterRound: Duration(seconds: 2),
                      showFadingOnlyWhenScrolling: true,
                      fadingEdgeStartFraction: 0.1,
                      fadingEdgeEndFraction: 0.1,
                      numberOfRounds: 30,
                      startPadding: 10.0,
                      accelerationDuration: Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            listOfTransactions.length == 0
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No Transactions added yet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
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
                          child: buildListView()),
                    ),
                  )
          ],
        ),
      ),
      drawer: MainDrawer(),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemBuilder: (cxt, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Rs ${listOfTransactions[index].amount}",
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
            trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  final transId = listOfTransactions[index].id;

                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.WARNING,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Delete Transaction',
                    desc: 'Are you sure ?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      setState(() {
                        deleteTransaction(transId);
                      });
                    },
                  )..show();
                }),
          ),
        ),
      ),
      itemCount: listOfTransactions.length,
    );
  }
}
