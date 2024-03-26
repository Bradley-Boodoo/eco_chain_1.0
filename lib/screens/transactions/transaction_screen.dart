import "package:eco_chain/theme.dart";
import "package:flutter/material.dart";

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            color: kSecondaryColor,
          ),
          Text(
            "Under Construction",
            style: TextStyle(color: kSecondaryColor),
          )
        ],
      ),
    );
  }
}
