import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:eco_chain/screens/splash_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Web3ModalTheme(
      isDarkMode: true,
      themeData: Web3ModalThemeData(
        darkColors: Web3ModalColors.darkMode.copyWith(
          accent100: kButtonColor,
          background125: kSecondaryColor,
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EcoChain',
        theme: ThemeData(
          canvasColor: kSecondaryColor,
          primaryColor: kPrimaryColor,
          textTheme: kTextTheme,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
