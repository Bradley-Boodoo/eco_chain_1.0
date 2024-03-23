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

class ReportBody extends StatefulWidget {
  const ReportBody({super.key});

  @override
  State<ReportBody> createState() => _ReportBodyState();
}

class _ReportBodyState extends State<ReportBody> {
  List<ReportModel> _reportList = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReportsCubit>(context).fetchBackendReports();

    return BlocListener<ReportsCubit, ReportsState>(
      listener: (context, state) {
        if (state is ReportsLoading) {
          Text('Loading...');
        }

        if (state is ReportsLoaded) {
          setState(() {
            _reportList = BlocProvider.of<ReportsCubit>(context).getReports();
          });
        }

        if (state is EmailSuccess) {
          setState(() {
            _reportList = BlocProvider.of<ReportsCubit>(context).getReports();
            BlocProvider.of<ReportsCubit>(context)
                .addBackendReports(state.reportDetails, 0, 0);
          });
        }

        if (state is EmailFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch email application')),
          );
        }
      },
      child: ListView.builder(
        itemCount: _reportList.length,
        itemBuilder: ((context, index) {
          return DisplayReport(report: _reportList[index]);
        }),
      ),
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
