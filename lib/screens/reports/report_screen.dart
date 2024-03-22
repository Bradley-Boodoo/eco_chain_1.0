import 'package:eco_chain/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showReportModal(context);
        },
        backgroundColor: const Color.fromARGB(136, 0, 248, 170),
        foregroundColor: kSecondaryColor,
        elevation: 2,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: const Center(child: Text("Report Screen")),
    );
  }

  void _showReportModal(BuildContext context) {
    final TextEditingController _textEditingController =
        TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textEditingController,
                decoration:
                    const InputDecoration(labelText: 'Enter Report Details'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _sendEmail(context, _textEditingController.text);
                },
                child: const Text('Send Report'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendEmail(BuildContext context, String reportDetails) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'predetermined@example.com',
      queryParameters: {
        'subject': 'New Report',
        'body': reportDetails,
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch email application'),
        ),
      );
    }
  }
}
