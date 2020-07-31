import 'package:budget_management/screens/tab_screen.dart';
import 'package:budget_management/services/shared_prefs.dart';
import 'package:budget_management/widgets/main_drawer.dart';
import 'package:confetti/confetti.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';

class AddIncome extends StatefulWidget {
  static const String routeName = '/add_income';

  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _autoValidate1 = false;
  ConfettiController _controllerCenter;
  double _userIncome;
  double _userInitIncome;
  double _savings;

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    super.initState();
    _loadInitial();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  _loadInitial() async {
    var userInitIncome = await SharedPreference().getInitialIncome();
    var userIncome = await SharedPreference().getIncome();
    var userSavings = await SharedPreference().getSavings();
    setState(() {
      _userIncome = userIncome;
      _userInitIncome = userInitIncome;
      _savings = userSavings;
    });
  }

  _setSavings(double saving) async {
    final bool result = await SharedPreference().setSavings(saving);
    if (result) {
    } else {}
  }

  incomeAddedSuccessfully() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor: Colors.white,
            content: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                child: Icon(
                                  Icons.done_all,
                                  size: 60,
                                  color: Colors.green,
                                )),
                            Positioned(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.022,
                              left: 8,
                              right: 4,
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: ConfettiWidget(
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
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          "Income Added",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "OpenSans-CondBold",
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          Navigator.of(context)
                              .pushReplacementNamed(TabScreen.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.47,
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
                                    "Done",
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
                    ),
                  ],
                ),
              ),
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

  _setInitialIncome(double income) async {
    final bool result = await SharedPreference().setInitialIncome(income);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          "Add Income",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(children: <Widget>[
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
                    width: MediaQuery.of(context).size.width * 0.48,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 6.0, bottom: 5, left: 5, right: 5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Marquee(
                          text: 'Add Your Income',
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                          'date': DateTime.now(),
                          'amount': "",
                          'add_savings': false,
                        },
                        child: Column(children: <Widget>[
                          FormBuilderTextField(
                            attribute: "amount",
                            keyboardType: TextInputType.number,
                            maxLines: 1,
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
                              'Salary',
                              'other',
                            ]
                                .map((cat) => DropdownMenuItem(
                                    value: cat, child: Text("$cat")))
                                .toList(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          FormBuilderCheckbox(
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            activeColor: Colors.green,
                            checkColor: Colors.amber,
                            attribute: 'add_savings',
                            label: Text(
                              "Transfer Remaining Balance to Savings",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035),
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
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                onPressed: () {
                                  if (_fbKey.currentState.saveAndValidate()) {
                                    print(_fbKey.currentState.value);
                                    print(_fbKey
                                        .currentState.value["add_savings"]);
                                    if (_fbKey
                                        .currentState.value["add_savings"]) {
                                      final double updatedIncome = double.parse(
                                          _fbKey.currentState.value['amount']);

                                      final double updatedInitialIncome =
                                          double.parse(_fbKey
                                              .currentState.value['amount']);
                                      final double updatedSavings =
                                          _savings + _userIncome;
                                      _setSavings(updatedSavings);

                                      _setInitialIncome(updatedInitialIncome);
                                      _setIncome(updatedIncome);
                                    } else {
                                      final double updatedIncome = _userIncome +
                                          double.parse(_fbKey
                                              .currentState.value['amount']);
                                      final double updatedInitialIncome =
                                          _userInitIncome +
                                              double.parse(_fbKey.currentState
                                                  .value['amount']);
                                      _setInitialIncome(updatedInitialIncome);
                                      _setIncome(updatedIncome);
                                    }

                                    incomeAddedSuccessfully();
                                    _controllerCenter.play();
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
