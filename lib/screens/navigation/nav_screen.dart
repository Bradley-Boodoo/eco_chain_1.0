import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../reports/report_screen.dart';
import '../transactions/transaction_screen.dart';

import '../../constants.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currentIndex = 0;

  final List<Widget> _bodyOptions = <Widget>[
    const HomeScreen(),
    const TransactionScreen(),
    const ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      // Body
      body: Container(
        child: _bodyOptions.elementAt(_currentIndex),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: buildBottomNav(),
    );
  }

  // Bottom Navigation Bar
  BottomNavigationBar buildBottomNav() {
    return BottomNavigationBar(
      //
      fixedColor: kPrimaryColor,
      backgroundColor: kSecondaryColor,
      currentIndex: _currentIndex,
      unselectedItemColor: kBackgroundColor,

      items: const <BottomNavigationBarItem>[
        // Home Icon
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),

        // Bill Icon
        BottomNavigationBarItem(
          icon: Icon(Icons.payment_rounded),
          label: 'Transactions',
        ),

        // Account Icon
        BottomNavigationBarItem(
          icon: Icon(Icons.report),
          label: 'Report',
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
