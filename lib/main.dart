import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'screens/navigation/nav_screen.dart';
//import 'screens/wallet_connector.dart';
import 'constants.dart';

void main() {
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
          accent100: kPrimaryColor,
          background125: kSecondaryColor,
        ),
      ),
      child: MaterialApp(
        title: 'EcoChain',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
        ),
        home: const NavScreen(),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inverseSurface,
//         title: SvgPicture.asset(
//           'assets/images/green_logo_white_text.svg',
//           height: kToolbarHeight * 2.5,
//         ),
//         actions: [
//           Row(
//             children: [
//               SizedBox(
//                 height: kToolbarHeight * 3 / 4,
//                 child: FloatingActionButton.extended(
//                   onPressed: () {
//                     // Add your onPressed logic here
//                   },
//                   label: const Text('Connect Wallet'),
//                   icon: const Icon(Icons.wallet),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
