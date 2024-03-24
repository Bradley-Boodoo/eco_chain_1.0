import 'package:eco_chain/models/report_model.dart';

class MySingleton {
  MySingleton._(); // Private constructor

  // Singleton instance
  static final MySingleton _instance = MySingleton._();

  // Factory method to access the singleton instance
  factory MySingleton() => _instance;

  // List to store items
  final List<ReportModel> _reports = [];

  // Getter to access the list
  List<ReportModel> get reports => _reports;

  // Method to get the length of the list
  int get reportsLength => _reports.length;

  // Method to add item to the list
  void addItem(ReportModel report) {
    _reports.insert(0, report);
  }
}
