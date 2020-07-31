import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budget_management/model/transaction.dart';
import 'package:budget_management/screens/tab_screen.dart';
import 'package:budget_management/services/shared_prefs.dart';
import 'package:budget_management/widgets/main_drawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';

class AddTransaction extends StatefulWidget {
  static const String routeName = '/add_transaction';

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<Transaction> listOfTransactions = [];
  bool _autoValidate = false;
  final _titleFocusNode = FocusNode();
  bool _autoValidate1 = false;
  double _userIncome = 0.0;
  double medi, groc, educ, dailn, fest, othe, homea, debts;
  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    super.initState();

    _loadInitial();
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  _loadInitial() async {
    var initTransaction = await SharedPreference().getTransactions();
    var userIncome = await SharedPreference().getIncome();
    var medical = await SharedPreference().getMedicals();
    var grocery = await SharedPreference().getGroceries();
    var education = await SharedPreference().getEducation();
    var dailyneeds = await SharedPreference().getDailyneeds();
    var festivals = await SharedPreference().getFestivals();
    var debt = await SharedPreference().getDebt();
    var homeapps = await SharedPreference().getHomeapps();
    var others = await SharedPreference().getOthers();
    _userIncome = userIncome;
    medi = double.parse(medical);
    groc = double.parse(grocery);
    educ = double.parse(education);
    dailn = double.parse(dailyneeds);
    fest = double.parse(festivals);
    debts = double.parse(debt);
    homea = double.parse(homeapps);
    othe = double.parse(others);

    final List<Transaction> decodedData =
        Transaction.decodeTransactions(initTransaction);
    setState(() {
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
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(children: <Widget>[
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
                    width: MediaQuery.of(context).size.width * 0.74,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Marquee(
                          text: 'Add Your Current Transaction',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 20.0,
                          velocity: 50.0,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FormBuilder(
                        key: _fbKey,
                        initialValue: {
                          'title': "",
                          'date': DateTime.now(),
                          'amount': "",
                        },
                        child: Column(children: <Widget>[
                          FormBuilderTextField(
                            attribute: "amount",
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_titleFocusNode);
                            },
                            decoration: InputDecoration(labelText: "Amount"),
                            autovalidate: _autoValidate1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.numberWithOptions(),
                            onTap: () {
                              setState(() {
                                _autoValidate1 = true;
                              });
                            },
                            validators: [
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.max(_userIncome),
                              FormBuilderValidators.required()
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          FormBuilderTextField(
                            autovalidate: _autoValidate,
                            focusNode: _titleFocusNode,
                            attribute: "title",
                            textInputAction: TextInputAction.next,
                            onTap: () {
                              setState(() {
                                _autoValidate = true;
                              });
                            },
                            decoration: InputDecoration(labelText: "Title"),
                            validators: [FormBuilderValidators.required()],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          FormBuilderDateTimePicker(
                            attribute: "date",
                            lastDate: DateTime.now(),
                            inputType: InputType.date,
                            format: DateFormat("dd-MM-yyyy"),
                            validators: [FormBuilderValidators.required()],
                            decoration:
                                InputDecoration(labelText: "Transaction Date"),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          FormBuilderDropdown(
                            attribute: "category",
                            decoration: InputDecoration(labelText: "Category"),
                            // initialValue: 'Male',
                            hint: Text('Select Category'),
                            validators: [FormBuilderValidators.required()],
                            items: [
                              'Medical',
                              'Grocery',
                              'Education',
                              'Daily Needs',
                              'Festival',
                              'Home Appliances',
                              'Debt/EMI',
                              'Others'
                            ]
                                .map((cat) => DropdownMenuItem(
                                    value: cat, child: Text("$cat")))
                                .toList(),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.055),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: MaterialButton(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                onPressed: () {
                                  if (_fbKey.currentState.saveAndValidate()) {
                                    print(_fbKey.currentState.value['title']
                                        .toString());
                                    print(_fbKey.currentState.value);
                                    Transaction newTransaction = Transaction(
                                        id: DateTime.now().toString(),
                                        title:
                                            _fbKey.currentState.value['title'],
                                        date: _fbKey.currentState.value['date']
                                            .toString(),
                                        amount: double.parse(_fbKey
                                            .currentState.value['amount']),
                                        category: _fbKey
                                            .currentState.value['category']);

                                    listOfTransactions.insert(
                                        0, newTransaction);

                                    final String encodedData =
                                        Transaction.encodeTransactions(
                                            listOfTransactions);
                                    final double deductedIncome = _userIncome -
                                        double.parse(_fbKey
                                            .currentState.value['amount']);
                                    if (_fbKey.currentState.value['category'] ==
                                        "Medical") {
                                      final double catAmnt = medi +
                                          double.parse(_fbKey
                                              .currentState.value['amount']);
                                      _setMedicals(catAmnt.toString());
                                    } else if (_fbKey
                                            .currentState.value['category'] ==
                                        "Grocery") {
                                      final double catAmnt = groc +
                                          double.parse(_fbKey
                                              .currentState.value['amount']);
                                      _setGroceries(catAmnt.toString());
                                    } else if (_fbKey
                                            .currentState.value['category'] ==
                                        "Education") {
                                      final double catAmnt = educ +
                                          double.parse(_fbKey
                                              .currentState.value['amount']);
                                      _setEducation(catAmnt.toString());
                                    } else if (_fbKey
                                            .currentState.value['category'] ==
                                        "Daily Needs") {
                                      final double catAmnt = dailn +
                                          double.parse(_fbKey
                                              .currentState.value['amount']);
                                      _setDailyneeds(catAmnt.toString());
                                    } else if (_fbKey
                                            .currentState.value['category'] ==
                                        "Festival") {
                                      final double catAmnt = fest +
                                          double.parse(_fbKey
                                              .currentState.value['amount']);
                                      _setFestivals(catAmnt.toString());
                                    } else if (_fbKey
                                            .currentState.value['category'] ==
                                        "Home Appliances") {
                                      final double catAmnt = homea +
                                          double.parse(_fbKey
                                              .currentState.value['amount']);
                                      _setHomeapps(catAmnt.toString());
                                    } else if (_fbKey
                                            .currentState.value['category'] ==
                                        "Debt/EMI") {
                                      final double catAmnt = debts +
                                          double.parse(_fbKey
                                              .currentState.value['amount']);
                                      _setDebts(catAmnt.toString());
                                    } else if (_fbKey
                                            .currentState.value['category'] ==
                                        "Others") {
                                      final double catAmnt = othe +
                                          double.parse(_fbKey
                                              .currentState.value['amount']);
                                      _setOthers(catAmnt.toString());
                                    }
                                    _setIncome(deductedIncome);
                                    _setTransactions(encodedData);
                                    print(encodedData);
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.SCALE,
                                      dialogType: DialogType.SUCCES,
                                      title: 'Done',
                                      desc: 'Transaction Successfully Added',
                                      dismissOnTouchOutside: false,
                                      dismissOnBackKeyPress: false,
                                      btnOkOnPress: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                TabScreen.routeName);
                                      },
                                    )..show();
                                  } else {}
                                },
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
