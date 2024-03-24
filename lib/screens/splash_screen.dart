import 'package:eco_chain/constants.dart';
import 'package:eco_chain/screens/navigation/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goHome();
  }

  _goHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const NavScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(child: SvgPicture.asset('assets/eco_chain_logo.svg')),
    );
  }
}
