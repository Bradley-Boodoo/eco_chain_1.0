import 'package:eco_chain/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/display_report.dart';
import 'cubit/reports_cubit.dart';
import 'package:eco_chain/constants.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit(),
      child: const Scaffold(
        backgroundColor: kBackgroundColor,
        floatingActionButton: CreateReportButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: ReportBody(),
      ),
    );
  }
}

// class ReportBody extends StatelessWidget {
//   const ReportBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReportsCubit, ReportsState>(
//       builder: (context, state) {
//         if (state is ReportsLoading) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (state is ReportsLoaded) {
//           final reportList = context.read<ReportsCubit>().getReports();
//           return ListView.builder(
//             itemCount: reportList.length,
//             itemBuilder: (context, index) {
//               return DisplayReport(report: reportList[index]);
//             },
//           );
//         }

//         return Container(); // Handle other states if necessary
//       },
//     );
//   }
// }

class CreateReportButton extends StatelessWidget {
  const CreateReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<ReportsCubit>(context).showReportModal(context);
      },
      backgroundColor: kButtonColor,
      foregroundColor: kSecondaryColor,
      elevation: 2,
      child: const Icon(Icons.add),
    );
  }
}

class ReportBody extends StatelessWidget {
  const ReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReportsCubit>(context).fetchBackendReports();

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        if (state is ReportsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: kSecondaryColor),
          );
        }

        if (state is ReportsLoaded) {
          return ListView.builder(
            itemCount: state.singleton.reportsLength,
            itemBuilder: (context, index) {
              return DisplayReport(report: state.singleton.reports[index]);
            },
          );
        }
        return Container();
      },
    );
  }
}

class MySingleton {
  MySingleton._(); // Private constructor

  // Singleton instance
  static final MySingleton _instance = MySingleton._();

  // Factory method to access the singleton instance
  factory MySingleton() => _instance;

  // List to store items
  List<ReportModel> _reports = [];

  // Getter to access the list
  List<ReportModel> get reports => _reports;

  // Method to get the length of the list
  int get reportsLength => _reports.length;

  // Method to add item to the list
  void addItem(ReportModel report) {
    _reports.insert(0, report);
  }
}
