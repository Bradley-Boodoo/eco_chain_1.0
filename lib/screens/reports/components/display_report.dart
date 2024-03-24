import 'package:flutter/material.dart';

import 'package:eco_chain/constants.dart';
import 'package:eco_chain/models/report_model.dart';

class DisplayReport extends StatefulWidget {
  const DisplayReport({super.key, required this.report});

  final ReportModel report;

  @override
  State<DisplayReport> createState() => _DisplayReportState();
}

class _DisplayReportState extends State<DisplayReport> {
  int upVotes = 0; // Counter for up votes
  int downVotes = 0; // Counter for down votes
  bool isUpSelected = false;
  bool isDownSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      //
      margin: const EdgeInsets.all(8.0),
      color: kSecondaryColor.withOpacity(0.75),

      child: ListTile(
        textColor: kBackgroundColor,
        title: Text(widget.report.getReportDetails()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //

            // Upvotes
            GestureDetector(
              onTap: () {
                setState(() {
                  isUpSelected = true;
                  upVotes++;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_drop_up_rounded,
                    color: isUpSelected ? kButtonColor : kBackgroundColor,
                  ),
                  Text(
                    '$upVotes',
                    style: TextStyle(
                      color: isUpSelected ? kButtonColor : kBackgroundColor,
                    ),
                  ),
                ],
              ),
            ),

            // Space
            const SizedBox(width: 8.0),

            //Downvotes
            GestureDetector(
              onTap: () {
                setState(() {
                  isDownSelected = true;
                  downVotes++;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: isDownSelected ? kButtonColor : kBackgroundColor,
                  ),
                  Text(
                    '$downVotes',
                    style: TextStyle(
                      color: isDownSelected ? kButtonColor : kBackgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
