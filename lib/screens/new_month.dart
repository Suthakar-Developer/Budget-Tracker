import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budget_management/model/history_transaction.dart';
import 'package:budget_management/model/transaction.dart';
import 'package:budget_management/screens/tab_screen.dart';
import 'package:budget_management/services/shared_prefs.dart';
import 'package:budget_management/widgets/main_drawer.dart';
import 'package:confetti/confetti.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:marquee/marquee.dart';

class AddNewMonth extends StatefulWidget {
  static const String routeName = '/add_newmonth';
  @override
  _AddNewMonthState createState() => _AddNewMonthState();
}

class _AddNewMonthState extends State<AddNewMonth> {
  double _userInitIncome, _userIncome;
  List<TransactionHistory> transactionsHistory = [];
  List<Transaction> listOfTransactions = [];
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ConfettiController _controllerCenter;
  String medi, groc, educ, dailn, fest, othe, homea, debts;
  String month;
  String _date;
  bool _autoValidate1 = false;
  double _savings;

  _loadInitial() async {
    var medical = await SharedPreference().getMedicals();
    var grocery = await SharedPreference().getGroceries();
    var education = await SharedPreference().getEducation();
    var dailyneeds = await SharedPreference().getDailyneeds();
    var festivals = await SharedPreference().getFestivals();
    var debt = await SharedPreference().getDebt();
    var homeapps = await SharedPreference().getHomeapps();
    var others = await SharedPreference().getOthers();
    var userInitIncome = await SharedPreference().getInitialIncome();
    var initTransaction = await SharedPreference().getTransactions();
    var userIncome = await SharedPreference().getIncome();
    var initHistory = await SharedPreference().getHistory();
    var initDate = await SharedPreference().getStartDate();
    var userSavings = await SharedPreference().getSavings();
    final List<TransactionHistory> decodedData =
        TransactionHistory.decodeTransactions(initHistory);
    final List<Transaction> decodedTransData =
        Transaction.decodeTransactions(initTransaction);
    setState(() {
      if (initHistory != "[]") {
        transactionsHistory = decodedData;
      }
      if (initTransaction != "[]") {
        listOfTransactions = decodedTransData;
      }
      medi = medical;
      groc = grocery;
      educ = education;
      dailn = dailyneeds;
      fest = festivals;
      debts = debt;
      homea = homeapps;
      othe = others;
      _savings = userSavings;
      _userInitIncome = userInitIncome;
      _date = initDate;
      _userIncome = userIncome;
    });
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

  _setInitialIncome(double income) async {
    final bool result = await SharedPreference().setInitialIncome(income);
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

  _setSavings(double saving) async {
    final bool result = await SharedPreference().setSavings(saving);
    if (result) {
    } else {}
  }

  balanceToSavings() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: new Text(
            "START NEW MONTH",
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
          content: new SingleChildScrollView(
            child: FormBuilder(
              key: _fbKey,
              initialValue: {
                'add_savings': false,
              },
              child: Column(children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                FormBuilderTextField(
                  keyboardType: TextInputType.number,
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  attribute: "amount",
                  decoration: InputDecoration(labelText: "Amount"),
                  autovalidate: _autoValidate1,
                  onTap: () {
                    setState(() {
                      _autoValidate1 = true;
                    });
                  },
                  validators: [
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(1000000),
                    FormBuilderValidators.required()
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                FormBuilderCheckbox(
                  decoration: InputDecoration(border: InputBorder.none),
                  activeColor: Colors.green,
                  checkColor: Colors.amber,
                  attribute: 'add_savings',
                  label: Text(
                    "Transfer Remaining Balance to Savings ?",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Card(
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "UNCHECK THE BOX TO GET RID OF BALANCE!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: new Text("Close",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new FlatButton(
                          color: Colors.green,
                          child: new Text("Start",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          onPressed: () {
                            if (_fbKey.currentState.saveAndValidate()) {
                              final double spent =
                                  _userInitIncome - _userIncome;
                              final String mnthStrng =
                                  DateTime.now().toString();
                              final String actualDate =
                                  mnthStrng.substring(5, 7);
                              final int lastMonth = int.parse(actualDate) - 1;
                              final double newIncome = double.parse(
                                  _fbKey.currentState.value["amount"]);
                              print("History $transactionsHistory");
                              final String encodedTransData =
                                  Transaction.encodeTransactions(
                                      listOfTransactions);
                              TransactionHistory newTransactionHistory =
                                  TransactionHistory(
                                month: lastMonth.toString(),
                                transaction: encodedTransData,
                                amount: spent,
                                medical: medi,
                                grocery: groc,
                                dailyneeds: dailn,
                                debt: debts,
                                education: educ,
                                home: homea,
                                festival: fest,
                                others: othe,
                              );

                              transactionsHistory.insert(
                                  0, newTransactionHistory);
                              final String encodedData =
                                  TransactionHistory.encodeTransactions(
                                      transactionsHistory);
                              _setTransactionsHistory(encodedData);
                              print(
                                  "History ${_fbKey.currentState.value["add_savings"]}");
                              if (_fbKey.currentState.value["add_savings"]) {
                                final double updatedSavings =
                                    _savings + _userIncome;
                                _setSavings(updatedSavings);
                              }
                              setState(() {
                                _setMedicals("0.0");
                                _setGroceries("0.0");
                                _setEducation("0.0");
                                _setDailyneeds("0.0");
                                _setHomeapps("0.0");
                                _setFestivals("0.0");
                                _setDebts("0.0");
                                _setOthers("0.0");
                                _setIncome(newIncome);
                                _setInitialIncome(newIncome);
                                _setTransactions("[]");
                              });
                              Navigator.pop(context);
                              _controllerCenter.play();
                            }
                          }),
                    ),
                  ],
                )
              ]),
            ),
          ),
        );
      },
    );
  }

  _setIncome(double income) async {
    final bool result = await SharedPreference().setIncome(income);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);

    }
  }

  _setTransactions(String transactionDetails) async {
    final bool result =
        await SharedPreference().setTransactions(transactionDetails);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  _setTransactionsHistory(String transactionDetails) async {
    final bool result = await SharedPreference().setHistory(transactionDetails);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);
    }
  }

  bool checkDups(String month) {
    final bool result = transactionsHistory.any((element) {
      return element.month == month;
    });
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _loadInitial();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          "Start New Month",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
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
                    width: MediaQuery.of(context).size.width * 0.5,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Marquee(
                          text: 'Start New Month',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 20.0,
                          velocity: 45.0,
                          pauseAfterRound: Duration(seconds: 1),
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
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality
                      .explosive, // don't specify a direction, blast randomly
                  shouldLoop:
                      false, // start again as soon as the animation is finished
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ], // manually specify the colors to be used
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.green[200],
                    radius: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black26, width: 4)),
                        elevation: 10,
                        color: Colors.green,
                        onPressed: () {
                          final String mnthStrng = DateTime.now().toString();
                          final String actualDate = mnthStrng.substring(5, 7);
                          final int lastMonth = int.parse(actualDate) - 1;
                          if (checkDups(lastMonth.toString())) {
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.ERROR,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Invalid Request',
                                desc: "Can't add same month twice.",
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      TabScreen.routeName);
                                })
                              ..show();
                          } else if (_date == actualDate) {
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.ERROR,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Invalid Request',
                                desc:
                                    "You can start new month by end of this month.",
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      TabScreen.routeName);
                                })
                              ..show();
                          } else {
                            balanceToSavings();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.045,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.green[100],
                                    width: 2.0),
                                color: Colors.green),
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 4, 8, 4),
                                child: Center(
                                  child: Text(
                                    'START',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 3),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.335,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '''
                            
BY STARTING NEW MONTH : 

1. Last month details will be added to the history. 
                            
2. Category-wise details will reset.

3. All your previous transaction will be cleared.

                            ''',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.amber,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "NOTE : Starting New Month won't affect your savings!",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
