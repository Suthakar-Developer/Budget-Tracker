import 'package:budget_management/model/history_transaction.dart';
import 'package:budget_management/screens/transaction_history_list.dart';
import 'package:budget_management/services/shared_prefs.dart';
import 'package:budget_management/widgets/main_drawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeName = '/history_transaction';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final dateTextStyle = TextStyle(
      fontSize: 10, color: Colors.red[300], fontWeight: FontWeight.bold);
  List<TransactionHistory> historyTransactions = [];
  final cutOffYValue = 10.0;

  final List<FlSpot> dataList = [];

  _loadInitial() async {
    var initTransaction = await SharedPreference().getHistory();
    final List<TransactionHistory> decodedData =
        TransactionHistory.decodeTransactions(initTransaction);
    setState(() {
      if (initTransaction != "[]") {
        historyTransactions = decodedData;
      }
    });
    for (int i = 0; i < 12; i++) {
      if (historyTransactions.isNotEmpty) {
        if (historyTransactions.length > i) {
          dataList.insert(
              0,
              FlSpot(double.parse(historyTransactions[i].month) - 1,
                  historyTransactions[i].amount));
        }
      }
    }
    print(dataList);
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadInitial();
    super.initState();
  }

  String getMonth(String theMonth) {
    String month;
    if (theMonth == "1") {
      month = "January";
    } else if (theMonth == "2") {
      month = "Febrauary";
    } else if (theMonth == "3") {
      month = "March";
    } else if (theMonth == "4") {
      month = "April";
    } else if (theMonth == "5") {
      month = "May";
    } else if (theMonth == "6") {
      month = "June";
    } else if (theMonth == "7") {
      month = "July";
    } else if (theMonth == "8") {
      month = "August";
    } else if (theMonth == "9") {
      month = "September";
    } else if (theMonth == "10") {
      month = "October";
    } else if (theMonth == "11") {
      month = "November";
    } else if (theMonth == "12") {
      month = "December";
    }
    return month;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          "Transaction History",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
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
                width: MediaQuery.of(context).size.width * 0.65,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Marquee(
                      text: 'Your Transaction History',
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            Expanded(
              child: Container(
                width: double.maxFinite,
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.amber, width: 3),
                              bottom:
                                  BorderSide(color: Colors.amber, width: 3))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4, top: 8, bottom: 8),
                        child: historyTransactions.isEmpty
                            ? Center(
                                child: Text(
                                "Histories will be shown once you complete a month and started a new month.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ))
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (cxt, index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HistoryList(
                                                  transaction:
                                                      historyTransactions[index]
                                                          .transaction,
                                                )));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.99,
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${getMonth(historyTransactions[index].month)}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Total : ₹ ${historyTransactions[index].amount}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                      fontSize: 16),
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            "Category-wise",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber,
                                                fontSize: 15),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Medical : ₹ ${historyTransactions[index].medical}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Grocery : ₹ ${historyTransactions[index].grocery}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Daily Needs : ₹ ${historyTransactions[index].dailyneeds}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Festival : ₹ ${historyTransactions[index].festival}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Education : ₹ ${historyTransactions[index].education}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Home Needs : ₹ ${historyTransactions[index].home}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontSize: 13),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Debt/EMI : ₹ ${historyTransactions[index].debt}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Others : ₹ ${historyTransactions[index].others}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontSize: 13),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                itemCount: historyTransactions.length,
                              ),
                      ),
                    )),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: Theme.of(context).accentColor,
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: dataList.isEmpty
                        ? Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Analysis will be shown after the completion of first month.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: LineChart(
                              LineChartData(
                                lineTouchData: LineTouchData(enabled: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    preventCurveOverShooting: true,
                                    spots: dataList,
                                    isCurved: true,
                                    barWidth: 8,
                                    colors: [
                                      Colors.red[300],
                                      Colors.amber,
                                      Colors.green
                                    ],
                                    belowBarData: BarAreaData(
                                      show: true,
                                      colors: [Colors.green.withOpacity(0.4)],
                                      cutOffY: cutOffYValue,
                                      applyCutOffY: true,
                                    ),
                                    aboveBarData: BarAreaData(
                                      show: true,
                                      colors: [Colors.amber.withOpacity(0.6)],
                                      cutOffY: cutOffYValue,
                                      applyCutOffY: true,
                                    ),
                                    dotData: FlDotData(
                                      show: true,
                                    ),
                                  ),
                                ],
                                minY: 0,
                                titlesData: FlTitlesData(
                                  bottomTitles: SideTitles(
                                      margin: 5,
                                      showTitles: true,
                                      reservedSize: 14,
                                      textStyle: dateTextStyle,
                                      getTitles: (value) {
                                        switch (value.toInt()) {
                                          case 0:
                                            return 'Jan';
                                          case 1:
                                            return 'Feb';
                                          case 2:
                                            return 'Mar';
                                          case 3:
                                            return 'Apr';
                                          case 4:
                                            return 'May';
                                          case 5:
                                            return 'Jun';
                                          case 6:
                                            return 'Jul';
                                          case 7:
                                            return 'Aug';
                                          case 8:
                                            return 'Sep';
                                          case 9:
                                            return 'Oct';
                                          case 10:
                                            return 'Nov';
                                          case 11:
                                            return 'Dec';
                                          default:
                                            return '';
                                        }
                                      }),
                                  leftTitles: SideTitles(
                                    margin: 8,
//                                  interval: 5000,
                                    showTitles: true,
                                    textStyle: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    getTitles: (value) {
                                      return '₹${value.round()}';
                                    },
                                  ),
                                ),
                                axisTitleData: FlAxisTitleData(
                                    leftTitle: AxisTitle(
                                        showTitle: true,
                                        titleText: '    ',
                                        margin: 5),
                                    bottomTitle: AxisTitle(
                                        showTitle: true,
                                        margin: 0,
                                        textStyle: dateTextStyle,
                                        titleText: 'Months',
                                        textAlign: TextAlign.right)),
                                gridData: FlGridData(
                                  show: true,
                                  checkToShowHorizontalLine: (double value) {
                                    return value == 1 ||
                                        value == 6 ||
                                        value == 4 ||
                                        value == 5;
                                  },
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
      drawer: MainDrawer(),
    );
  }
}
