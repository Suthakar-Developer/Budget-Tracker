import 'dart:convert';

class TransactionHistory {
  String month;
  String medical;
  String grocery;
  String education;
  String dailyneeds;
  String home;
  String debt;
  String festival;
  String others;
  String transaction;
  double amount;

  TransactionHistory(
      {this.amount,
      this.month,
      this.medical,
      this.grocery,
      this.education,
      this.transaction,
      this.dailyneeds,
      this.home,
      this.debt,
      this.festival,
      this.others});

  factory TransactionHistory.fromJson(Map<String, dynamic> jsonData) {
    return TransactionHistory(
      amount: jsonData['amount'],
      month: jsonData['month'],
      medical: jsonData['medical'],
      grocery: jsonData['grocery'],
      education: jsonData['education'],
      dailyneeds: jsonData['dailyneeds'],
      debt: jsonData['debt'],
      home: jsonData['home'],
      transaction: jsonData['transaction'],
      festival: jsonData['festival'],
      others: jsonData['others'],
    );
  }

  static Map<String, dynamic> toMap(TransactionHistory transactionHistory) => {
        'amount': transactionHistory.amount,
        'month': transactionHistory.month,
        'medical': transactionHistory.medical,
        'grocery': transactionHistory.grocery,
        'education': transactionHistory.education,
        'dailyneeds': transactionHistory.dailyneeds,
        'debt': transactionHistory.debt,
        'transaction': transactionHistory.transaction,
        'home': transactionHistory.home,
        'festival': transactionHistory.festival,
        'others': transactionHistory.others
      };

  static String encodeTransactions(List<TransactionHistory> transactions) =>
      json.encode(
        transactions
            .map<Map<String, dynamic>>(
                (transaction) => TransactionHistory.toMap(transaction))
            .toList(),
      );

  static List<TransactionHistory> decodeTransactions(String transactions) =>
      (json.decode(transactions) as List<dynamic>)
          .map<TransactionHistory>((item) => TransactionHistory.fromJson(item))
          .toList();
}
