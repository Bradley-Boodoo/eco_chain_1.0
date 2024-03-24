import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eco_chain/constants.dart';
import 'package:eco_chain/screens/navigation/nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 2, end: 0).animate(_controller);

    _controller.forward().then((_) {
      // After animation completes, navigate to NavScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Stack(
        children: [
          // NavScreen
          Container(
            color: kBackgroundColor,
          ),
          // SplashScreen with FadeTransition
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              color: kSecondaryColor,
              child: Center(
                child: SvgPicture.asset('assets/eco_chain_logo.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
