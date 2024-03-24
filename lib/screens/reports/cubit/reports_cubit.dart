import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_chain/constants.dart';
import 'package:eco_chain/models/report_model.dart';
import 'package:eco_chain/screens/reports/report_screen.dart';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:url_launcher/url_launcher.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitial());

  MySingleton reports = MySingleton();

  // Fetches Reports from the Firebase Backend
  Future fetchBackendReports() async {
    emit(ReportsLoading());

    await FirebaseFirestore.instance.collection('reports').get().then(
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
        ReportModel report = ReportModel(details: data['reportDetails']);
        reports.addItem(report);

        // Emit your state if necessary
        // emit(ReportsLoaded(reports)); // Example of emitting a state
      } else {
        // Document doesn't exist
        // Handle the case when the document doesn't exist
      }
    } catch (e) {
      // Handle any errors that might occur
      print("Error retrieving report: $e");
    }
    emit(ReportsLoaded(singleton: reports));
  }

  // Adds Reports to the Firebase Backend
  Future addBackendReports(String details, int upVotes, int downVotes) async {
    await FirebaseFirestore.instance.collection('reports').add(
        {'reportDetails': details, 'upVotes': upVotes, 'downVotes': downVotes});
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
                  sendEmail(context, textEditingController.text);
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

  void sendEmail(BuildContext context, String reportDetails) async {
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
      ReportModel report = ReportModel(details: reportDetails);
      reports.addItem(report);
      emit(ReportsLoaded(singleton: reports));
      addBackendReports(report.getReportDetails(), 0, 0);
    } else {
      emit(EmailFailed());
    }
  }
}
