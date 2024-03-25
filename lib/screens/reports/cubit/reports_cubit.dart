import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:eco_chain/models/reports/report_model.dart';
import '../../../models/reports/singleton.dart';

import 'package:eco_chain/theme.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitial());

  MySingleton reports = MySingleton();

  // Fetches Reports from the Firebase Backend
  Future fetchBackendReports() async {
    emit(ReportsLoading());

    await FirebaseFirestore.instance
        .collection('reports')
        .orderBy('date', descending: false)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) async {
              await convertBackendReport(document.reference.id);
            },
          ),
        );
  }

  // Converts the report IDs to a report
  Future<void> convertBackendReport(String reportID) async {
    CollectionReference coll = FirebaseFirestore.instance.collection('reports');

    try {
      DocumentSnapshot snapshot = await coll.doc(reportID).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        ReportModel report = ReportModel(
          id: reportID,
          timestamp: data['date'],
          details: data['reportDetails'],
          numUp: data['upVotes'],
          numDown: data['downVotes'],
          upSelected: data['upSelected'],
          downSelected: data['downSelected'],
        );
        reports.addItem(report);

        emit(ReportsLoaded(singleton: reports));
      } else {}
    } catch (e) {
      print("Error retrieving report: $e");
    }
  }

  // Adds Reports to the Firebase Backend
  Future addBackendReports(String details, Timestamp timestamp) async {
    await FirebaseFirestore.instance.collection('reports').add({
      'date': timestamp,
      'reportDetails': details,
      'upSelected': false,
      'downSelected': false,
      'upVotes': 0,
      'downVotes': 0,
    });
  }

  void showReportModal(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    showModalBottomSheet(
      backgroundColor: kSecondaryColor,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: kBackgroundColor),
                  labelText: 'Enter Report Details',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kBackgroundColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kSecondaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  sendEmail(
                    context,
                    textEditingController.text,
                    Timestamp.now(),
                  );
                  textEditingController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kButtonColor,
                  foregroundColor: kBackgroundColor,
                ),
                child: const Text('Send Report'),
              ),
            ],
          ),
        );
      },
    );
  }

  void sendEmail(
    BuildContext context,
    String reportDetails,
    Timestamp timestamp,
  ) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: 'complaints@ema.co.tt', //Environmental Management Authority
      queryParameters: {
        'subject': 'New Report',
        'body': reportDetails,
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);

      addBackendReports(reportDetails, timestamp);
    } else {
      emit(EmailFailed());
    }
  }

  @override
  Future<void> close() {
    reports.reports.clear();
    return super.close();
  }
}
