import 'dart:convert';

class Transaction {
  String id;
  String title;
  String category;
  double amount;
  String date;

  Transaction({this.id, this.title, this.amount, this.date, this.category});

  factory Transaction.fromJson(Map<String, dynamic> jsonData) {
    return Transaction(
      id: jsonData['id'],
      title: jsonData['title'],
      amount: jsonData['amount'],
      date: jsonData['date'],
      category: jsonData['category'],
    );
  }

  static Map<String, dynamic> toMap(Transaction transaction) => {
        'id': transaction.id,
        'title': transaction.title,
        'amount': transaction.amount,
        'date': transaction.date,
        'category': transaction.category,
      };

  static String encodeTransactions(List<Transaction> transactions) =>
      json.encode(
        transactions
            .map<Map<String, dynamic>>(
                (transaction) => Transaction.toMap(transaction))
            .toList(),
      );

  static List<Transaction> decodeTransactions(String transactions) =>
      (json.decode(transactions) as List<dynamic>)
          .map<Transaction>((item) => Transaction.fromJson(item))
          .toList();
}
