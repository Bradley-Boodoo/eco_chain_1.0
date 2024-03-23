import 'package:eco_chain/constants.dart';
import 'package:eco_chain/models/report_model.dart';
import 'package:flutter/material.dart';

class DisplayReport extends StatelessWidget {
  const DisplayReport({super.key, required this.report});

  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    int upVotes = 0; // Counter for up votes
    int downVotes = 0; // Counter for down votes

    return Card(
      //
      margin: const EdgeInsets.all(8.0),
      color: kSecondaryColor.withOpacity(0.75),

      child: ListTile(
        textColor: kBackgroundColor,
        iconColor: kBackgroundColor,
        title: Text(report.getReportDetails()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //

            // Upvotes
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_drop_up_rounded),
                  Text('$upVotes'),
                ],
              ),
            ),

            // Space
            const SizedBox(width: 8.0),

            //Downvotes
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_drop_down_rounded),
                  Text('$downVotes'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
