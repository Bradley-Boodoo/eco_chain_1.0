import 'package:eco_chain/constants.dart';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:url_launcher/url_launcher.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitial());

  List<Widget> buildReportCards(List<String> reportDetailsList) {
    List<Widget> cards = [];
    for (int i = 0; i < reportDetailsList.length; i++) {
      int upVotes = 0; // Counter for up votes
      int downVotes = 0; // Counter for down votes
      cards.add(
        Card(
          margin: const EdgeInsets.all(8.0),
          color: kSecondaryColor.withOpacity(0.75),
          child: ListTile(
            textColor: kBackgroundColor,
            iconColor: kBackgroundColor,
            title: Text(reportDetailsList[i]),
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
        ),
      );
    }
    return cards;
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
      emit(EmailSuccess(reportDetails));
    } else {
      emit(EmailFailed());
    }
  }
}
