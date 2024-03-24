import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:eco_chain/theme.dart';
import 'package:eco_chain/models/reports/report_model.dart';

class DisplayReport extends StatefulWidget {
  final ReportModel report;

  const DisplayReport({
    super.key,
    required this.report,
  });

  @override
  State<DisplayReport> createState() => _DisplayReportState();
}

class _DisplayReportState extends State<DisplayReport> {
  @override
  Widget build(BuildContext context) {
    return Card(
      //
      margin: const EdgeInsets.all(8.0),
      color: kSecondaryColor.withOpacity(0.75),

      child: ListTile(
        textColor: kBackgroundColor,
        title: Text(widget.report.reportDetails),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //

            // Upvotes
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.report.incrUpVotes();
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_drop_up_rounded,
                    color: widget.report.isUpSelected
                        ? kButtonColor
                        : kBackgroundColor,
                  ),
                  Text(
                    '${widget.report.upVotes}',
                    style: TextStyle(
                      color: widget.report.isUpSelected
                          ? kButtonColor
                          : kBackgroundColor,
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
                  widget.report.incrDownVotes();
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: widget.report.isDownSelected
                        ? kButtonColor
                        : kBackgroundColor,
                  ),
                  Text(
                    '${widget.report.downVotes}',
                    style: TextStyle(
                      color: widget.report.isDownSelected
                          ? kButtonColor
                          : kBackgroundColor,
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
