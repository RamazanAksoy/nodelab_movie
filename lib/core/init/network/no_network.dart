import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../../product/widget/no_network_shet.dart';

class NoNetworkManager {
  final VoidCallback? onRetry;
  final bool isEnable;

  NoNetworkManager({required this.onRetry, this.isEnable = false});

  Future<void> show(BuildContext context) async {
    if (!isEnable) return;
    if (await _checkConnectivity()) return;

    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return NoNetworkBottomSheet(
          onRetry: () {
            Navigator.of(context).pop();
            onRetry?.call();
          },
        );
      },
    );
  }

  Future<bool> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
