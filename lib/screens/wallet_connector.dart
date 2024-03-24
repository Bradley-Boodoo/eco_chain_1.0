import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import "package:web3modal_flutter/web3modal_flutter.dart";

import "package:eco_chain/theme.dart";

class WalletConnector extends StatefulWidget {
  const WalletConnector({super.key});

  @override
  State<WalletConnector> createState() => _WalletConnectorState();
}

class _WalletConnectorState extends State<WalletConnector> {
  late W3MService _w3mService;
  @override
  void initState() {
    super.initState();
    initializeState();
  }

  void initializeState() async {
    W3MChainPresets.chains.putIfAbsent(_chainId, () => _sepoliaChain);
    _w3mService = W3MService(
      projectId: 'cab44e2c63acdb6b618c01173c0da40d',
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
        description: 'Web3Modal Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'flutterdapp://', // your own custom scheme
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );

    await _w3mService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/green_logo_white_text.svg'),
            const SizedBox(height: 16),
            W3MConnectWalletButton(service: _w3mService),
            const SizedBox(height: 16),
            W3MNetworkSelectButton(service: _w3mService),
            const SizedBox(height: 16),
            W3MAccountButton(service: _w3mService),
          ],
        ),
      ),
    );
  }
}

const _chainId = "11155111";

final _sepoliaChain = W3MChainInfo(
  chainName: 'Sepolia',
  namespace: 'eip155:$_chainId',
  chainId: _chainId,
  tokenName: 'ETH',
  rpcUrl: 'https://sepolia.infura.io/v3/',
  blockExplorer: W3MBlockExplorer(
    name: 'Sepolia Explorer',
    url: 'https://sepolia.etherscan.io/',
  ),
);
