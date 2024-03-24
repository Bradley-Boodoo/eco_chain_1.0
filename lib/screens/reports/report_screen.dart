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

        if (state is ReportsEmpty) {
          return const Center(child: Text('No Reports Found'));
        }

        return Container();
      },
    );
  }
}

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
