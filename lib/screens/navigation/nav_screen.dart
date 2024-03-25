import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../map/map_screen.dart';
import '../marketplace/marketplace_screen.dart';
import '../reports/report_screen.dart';
import '../transactions/transaction_screen.dart';

import '../../theme.dart';

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
    const MapScreen(),
    const ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      // Appbar
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/eco_chain_logo_green.svg',
          height: kToolbarHeight * 1.5,
        ),
        backgroundColor: kBackgroundColor,
      ),

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
        // Marketplace Icon
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Marketplace',
        ),

        // Transaction Icon
        BottomNavigationBarItem(
          icon: Icon(Icons.payment),
          label: 'Transactions',
        ),

        // Map Icon
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Map',
        ),

        // Report Icon
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
