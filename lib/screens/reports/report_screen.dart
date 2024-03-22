import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showReportModal(context);
        },
      ),
      const Center(child: Text("Report Screen")),
    ]);
  }

  void _showReportModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextField(
                decoration: InputDecoration(labelText: 'Enter Report Details'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _sendEmail(context);
                },
                child: const Text('Send Report'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendEmail(BuildContext context) async {
    const url =
        'mailto:predetermined@example.com?subject=New Report&body=Report Details';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch email application'),
        ),
      );
    }
  }
}
