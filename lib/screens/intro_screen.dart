import 'package:budget_management/screens/tab_screen.dart';
import 'package:budget_management/services/shared_prefs.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = '/intro_income';

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _autoValidate1 = false;
  double _userIncome;

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);

    super.initState();
    // _loadInitial();
  }

  // _loadInitial() async {
  //   var initTransaction = await SharedPreference().getTransactions();
  //   final List<Transaction> decodedData =
  //       Transaction.decodeTransactions(initTransaction);
  //   setState(() {
  //     if (initTransaction != "[]") {
  //       listOfTransactions = decodedData;
  //     }
  //   });
  // }

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
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                            child: Icon(
                              Icons.done_outline,
                              size: 60,
                              color: Colors.green,
                            )),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Center(
                          child: Text(
                            "Income Added Successfully",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "OpenSans-CondBold",
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
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

  _setStartDate(String date) async {
    final bool result = await SharedPreference().setStartDate(date);
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

  _setSeen(bool seen) async {
    final bool result = await SharedPreference().setSeen(seen);
    if (result) {
    } else {
      //showUserSnak('Please try again', true);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  width: MediaQuery.of(context).size.width * 0.52,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Marquee(
                        text: 'Add Your Income',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
                    child: SingleChildScrollView(
                      reverse: true,
                      child: FormBuilder(
                        key: _fbKey,
                        initialValue: {
                          'date': DateTime.now(),
                          'amount': "",
                        },
                        child: Column(children: <Widget>[
                          FormBuilderTextField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
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
                                InputDecoration(labelText: "Beginning Date"),
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
                              height:
                                  MediaQuery.of(context).size.height * 0.10),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: MaterialButton(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Add',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                onPressed: () {
                                  if (_fbKey.currentState.saveAndValidate()) {
                                    print(_fbKey.currentState.value);
                                    print(double.parse(
                                        _fbKey.currentState.value['amount']));
                                    _userIncome = double.parse(
                                        _fbKey.currentState.value['amount']);
                                    final String beginDate = _fbKey
                                        .currentState.value['date']
                                        .toString()
                                        .substring(5, 7);
                                    print(beginDate);
                                    _setSeen(true);
                                    _setStartDate(beginDate);
                                    _setInitialIncome(_userIncome);
                                    _setIncome(_userIncome);

                                    incomeAddedSuccessfully();
                                  } else {}
                                },
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
