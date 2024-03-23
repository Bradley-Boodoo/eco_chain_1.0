import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final List<String> _reportDetailsList = [];
  final List<Widget> _cards = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportsCubit, ReportsState>(
      listener: (context, state) {
        if (state is EmailSuccess) {
          setState(() {
            _reportDetailsList.insert(0, state.reportDetails);
          });
        }

        if (state is EmailFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch email application')),
          );
        }
      },
      child: ListView(
        children: BlocProvider.of<ReportsCubit>(context)
            .buildReportCards(_reportDetailsList),
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
