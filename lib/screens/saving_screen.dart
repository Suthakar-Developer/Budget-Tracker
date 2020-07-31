import 'package:budget_management/screens/tab_screen.dart';
import 'package:budget_management/services/shared_prefs.dart';
import 'package:budget_management/widgets/main_drawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:marquee/marquee.dart';

class SavingScreen extends StatefulWidget {
  static const routeName = "saving_screen";
  @override
  _SavingScreenState createState() => _SavingScreenState();
}

class _SavingScreenState extends State<SavingScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _autoValidate1 = false;
  bool _autoValidate = false;
  double _userIncome, _userInitIncome;
  double savingsAmnt = 0.0;

  _loadInitial() async {
    var userIncome = await SharedPreference().getIncome();
    var userInitIncome = await SharedPreference().getInitialIncome();
    var userSavings = await SharedPreference().getSavings();
    setState(() {
      _userIncome = userIncome;
      _userInitIncome = userInitIncome;
      savingsAmnt = userSavings;
    });
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
              "Money will be deducted from balance and added to savings",
              softWrap: true,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                  fontSize: 16)),
          content: new SingleChildScrollView(
            child: FormBuilder(
              key: _fbKey,
              initialValue: {
                'amount': "",
              },
              child: Column(children: <Widget>[
                FormBuilderTextField(
                  attribute: "amount",
                  decoration: InputDecoration(labelText: "Amount"),
                  autovalidate: _autoValidate,
                  keyboardType: TextInputType.number,
                  onTap: () {
                    setState(() {
                      _autoValidate = true;
                    });
                  },
                  validators: [
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(_userIncome),
                    FormBuilderValidators.required()
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                        child: new Text("Add it",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                        onPressed: () {
                          if (_fbKey.currentState.saveAndValidate()) {
                            print(_fbKey.currentState.value);
                            final double updatedIncome = _userIncome -
                                double.parse(
                                    _fbKey.currentState.value["amount"]);
                            _setIncome(updatedIncome);
                            final double updatedSavings = savingsAmnt +
                                double.parse(
                                    _fbKey.currentState.value["amount"]);
                            setState(() {
                              _setSavings(updatedSavings);
                            });
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.of(context)
                                .pushReplacementNamed(TabScreen.routeName);
                          } else {}
                        },
                      ),
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

  _setInitialIncome(double income) async {
    final bool result = await SharedPreference().setInitialIncome(income);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);

    }
  }

  _setIncome(double income) async {
    final bool result = await SharedPreference().setIncome(income);
    if (result) {
    } else {}
  }

  _setSavings(double saving) async {
    final bool result = await SharedPreference().setSavings(saving);
    if (result) {
    } else {}
  }

  savingsToBalance() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: new Text(
              "Money will be deducted from savings and added to balance",
              softWrap: true,
              style: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.w600,
                  fontSize: 16)),
          content: new SingleChildScrollView(
            child: FormBuilder(
              key: _fbKey,
              initialValue: {
                'amount': "",
              },
              child: Column(children: <Widget>[
                FormBuilderTextField(
                  attribute: "amount",
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Amount"),
                  autovalidate: _autoValidate1,
                  onTap: () {
                    setState(() {
                      _autoValidate1 = true;
                    });
                  },
                  validators: [
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(savingsAmnt),
                    FormBuilderValidators.required()
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                        child: new Text("Add it",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                        onPressed: () {
                          if (_fbKey.currentState.saveAndValidate()) {
                            print(_fbKey.currentState.value);
                            final double updatedIncome = _userIncome +
                                double.parse(
                                    _fbKey.currentState.value["amount"]);
                            final double updatedInitIncome = _userInitIncome +
                                double.parse(
                                    _fbKey.currentState.value["amount"]);
                            _setInitialIncome(updatedInitIncome);
                            _setIncome(updatedIncome);

                            final double updatedSavings = savingsAmnt -
                                double.parse(
                                    _fbKey.currentState.value["amount"]);
                            setState(() {
                              _setSavings(updatedSavings);
                            });
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.of(context)
                                .pushReplacementNamed(TabScreen.routeName);
                          } else {}
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _loadInitial();
    // TODO: implement initState
    super.initState();
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
          "Your Savings",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        )),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.44,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Marquee(
                          text: '  Your Savings',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Container(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attach_money,
                                    color: Colors.amber,
                                    size: 30,
                                  ),
                                  title: Text(
                                    "Savings",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "Save more money.",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  trailing: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        color: Colors.green,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text("₹ $savingsAmnt",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.white),
                                                maxLines: 1),
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              GestureDetector(
                                onTap: () {
                                  balanceToSavings();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "Add Money to Savings",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                              ),
                              GestureDetector(
                                onTap: () {
                                  savingsToBalance();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "Add Savings to Balance",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
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
