import 'package:eco_chain/models/reports/report_model.dart';

class MySingleton {
  MySingleton._(); // Private constructor

  static final MySingleton _instance = MySingleton._(); // Singleton instance
  factory MySingleton() => _instance;

  final List<ReportModel> _reports = []; // List to store items

  List<ReportModel> get reports => _reports; // Access to the list

  int get reportsLength => _reports.length; // Length of the list

  // Adds item to the list
  void addItem(ReportModel report) {
    _reports.insert(0, report);
  }
}
