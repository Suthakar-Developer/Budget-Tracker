import 'package:budget_management/services/shared_prefs.dart';
import 'package:budget_management/widgets/main_drawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, double> dataMap = Map();
  double _userIncome;
  double _userInitIncome;
  double medi, groc, educ, dailn, fest, othe, homea, debts;

  List<Color> colorList = [
    Colors.red[300],
    Colors.green[300],
    Colors.blue[200],
    Colors.yellow[200],
    Colors.pink[300],
    Colors.orange[300],
    Colors.purple[300],
    Colors.grey[400]
  ];

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
    var userIncome = await SharedPreference().getIncome();

    setState(() {
      medi = double.parse(medical);
      groc = double.parse(grocery);
      educ = double.parse(education);
      dailn = double.parse(dailyneeds);
      fest = double.parse(festivals);
      debts = double.parse(debt);
      homea = double.parse(homeapps);
      othe = double.parse(others);
      _userIncome = userIncome;
      _userInitIncome = userInitIncome;
      dataMap["Medical"] = medi;
      dataMap["Grocery"] = groc;
      dataMap["Education"] = educ;
      dataMap["Daily Needs"] = dailn;
      dataMap["Festival"] = fest;
      dataMap["Home Appliances"] = homea;
      dataMap["Debt/EMI"] = debts;
      dataMap["Others"] = othe;
    });
  }

  @override
  void initState() {
    _loadInitial();
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataMap["Others"] == null || _userIncome == null
          ? DoubleBackToCloseApp(
              snackBar: const SnackBar(
                content: Text('Tap back again to leave'),
              ),
              child: Column(
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
            )
          : DoubleBackToCloseApp(
              snackBar: const SnackBar(
                content: Text('Tap back again to leave'),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Status :",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            CircularPercentIndicator(
                              radius: 110.0,
                              animation: true,
                              curve: Curves.decelerate,
                              animationDuration: 1200,
                              lineWidth: 15.0,
                              percent:
                                  (_userIncome / _userInitIncome) * 100 / 100,
                              center: new Text(
                                "${((_userIncome / _userInitIncome) * 100).toStringAsFixed(1)}%",
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.butt,
                              backgroundColor: Color(0xffff7272),
                              progressColor: Colors.green[400],
                              footer: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: new Text(
                                  "% of Amount Remaining",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    child: ListTile(
                      leading: Icon(
                        Icons.account_balance,
                      ),
                      title: Text(
                        "Balance ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Spend it wisely.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      trailing: Chip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        label: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Rs $_userIncome",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
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
                      height: MediaQuery.of(context).size.height * 0.058,
                      width: MediaQuery.of(context).size.width * 0.47,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Marquee(
                            text: 'Budget Analysis ',
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
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: double.maxFinite,
                          child: _userIncome == _userInitIncome
                              ? Center(
                                  child: Text(
                                    "Make some transactions.",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 5),
                                  child: PieChart(
                                    dataMap: dataMap,
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    chartLegendSpacing:
                                        MediaQuery.of(context).size.width *
                                            0.12,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 2,
                                    showChartValuesInPercentage: true,
                                    showChartValues: true,
                                    showChartValuesOutside: true,
                                    chartValueBackgroundColor:
                                        Colors.transparent,
                                    colorList: colorList,
                                    showLegends: true,
                                    legendPosition: LegendPosition.right,
                                    decimalPlaces: 1,
                                    showChartValueLabel: true,
                                    chartValueStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                    chartType: ChartType.disc,
                                  ),
                                )),
                    ),
                  )
                ],
              ),
            ),
      drawer: MainDrawer(),
    );
  }
}
