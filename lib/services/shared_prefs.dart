import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  final String _ipKey = "ip";
  final String _userKey = "userid";
  final String _userNameKey = "username";
  final String _userMobileKey = "usermobile";
  final String _storeId = "storeid";
  final String _transactions = "transaction";
  final String _history = "history";
  final String _startingDate = "start";
  final String _medical = "medical";
  final String _groceries = "groceries";
  final String _dailyneeds = "dailyneeds";
  final String _education = "education";
  final String _homeAppls = "homeapps";
  final String _other = "others";
  final String _festivals = "festivals";
  final String _debt = "debt";

  final String _income = "income";
  final String _initialIncome = "initialIncome";
  final String _savings = "saving";
  final String _seen = "seen";
  final String _orderType = "ordertype";
  final String _minimumOrderValue = "minOrdVal";
  final String _totqty = "totalqty";
  final String _imageListViewBuild = "images";

  /// ----------------------------------------------------------
  /// Method that saves the ip address
  /// ----------------------------------------------------------
  Future<bool> setIpAddress(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_ipKey, value);
  }

  Future<bool> setMinOrdVal(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setDouble(_minimumOrderValue, value);
  }

  Future<bool> setIncome(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setDouble(_income, value);
  }

  Future<bool> setInitialIncome(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setDouble(_initialIncome, value);
  }

  Future<bool> setSavings(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setDouble(_savings, value);
  }

  Future<bool> setStartDate(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_startingDate, value);
  }

  Future<bool> setMedical(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_medical, value);
  }

  Future<bool> setGroceries(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_groceries, value);
  }

  Future<bool> setDailyneeds(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_dailyneeds, value);
  }

  Future<bool> setEducation(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_education, value);
  }

  Future<bool> setHomeapps(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_homeAppls, value);
  }

  Future<bool> setOther(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_other, value);
  }

  Future<bool> setFestivals(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_festivals, value);
  }

  Future<bool> setDebt(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_debt, value);
  }

  Future<bool> setImageView(List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setStringList(_imageListViewBuild, value);
  }

  Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_userKey, value);
  }

  Future<bool> setUserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_userNameKey, value);
  }

  Future<bool> setUserMobile(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_userMobileKey, value);
  }

  Future<bool> setSeen(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setBool(_seen, value);
  }

  Future<bool> setStoreID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_storeId, value);
  }

  Future<bool> setTransactions(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_transactions, value);
  }

  Future<bool> setHistory(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_history, value);
  }

  Future<bool> setorderType(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_orderType, value);
  }

  Future<bool> setTotalQty(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("im ***********from***************** service" + value.toString());
    return prefs.setString(_totqty, value);
  }

  /// ----------------------------------------------------------
  /// Method that gets the ip address
  /// ----------------------------------------------------------
  Future<String> getIpAdress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_ipKey) ?? "null";
  }

  Future<double> getMinOrdVl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(_minimumOrderValue) ?? 0.0;
  }

  Future<String> getStartDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_startingDate) ?? "";
  }

  Future<String> getMedicals() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_medical) ?? "0.0";
  }

  Future<String> getGroceries() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_groceries) ?? "0.0";
  }

  Future<String> getEducation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_education) ?? "0.0";
  }

  Future<String> getDailyneeds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_dailyneeds) ?? "0.0";
  }

  Future<String> getHomeapps() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_homeAppls) ?? "0.0";
  }

  Future<String> getOthers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_other) ?? "0.0";
  }

  Future<String> getDebt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_debt) ?? "0.0";
  }

  Future<String> getFestivals() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_festivals) ?? "0.0";
  }

  Future<double> getIncome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(_income) ?? 0.0;
  }

  Future<bool> getSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seen) ?? false;
  }

  Future<double> getInitialIncome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(_initialIncome) ?? 0.0;
  }

  Future<double> getSavings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(_savings) ?? 0.0;
  }

  Future<List<String>> getImageView() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_imageListViewBuild) ?? [];
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userKey) ?? "null";
  }

  Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userNameKey) ?? "null";
  }

  Future<String> getUserMobile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userMobileKey) ?? "null";
  }

  Future<String> getStoreID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_storeId) ?? "null";
  }

  Future<String> getTransactions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_transactions) ?? "[]";
  }

  Future<String> getHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_history) ?? "[]";
  }

  Future<String> getOrderType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_orderType) ?? "null";
  }

  Future<String> getTotalQty() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_totqty) ?? "";
  }
}
