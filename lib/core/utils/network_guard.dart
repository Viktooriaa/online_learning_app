import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../screens/main/no_network_screen.dart';

class NetworkGuard {
  NetworkGuard._();

  static Future<bool> hasConnection() async {
    final result = await Connectivity().checkConnectivity();
    return result.any(
      (type) =>
          type == ConnectivityResult.mobile ||
          type == ConnectivityResult.wifi ||
          type == ConnectivityResult.ethernet ||
          type == ConnectivityResult.vpn,
    );
  }

  static Future<T?> push<T>(
    BuildContext context,
    Widget Function() builder,
  ) async {
    if (!context.mounted) return null;

    if (!await hasConnection()) {
      return Navigator.of(context).push<T>(
        MaterialPageRoute(builder: (_) => const NoNetworkScreen()),
      );
    }

    if (!context.mounted) return null;
    return Navigator.of(context).push<T>(
      MaterialPageRoute(builder: (_) => builder()),
    );
  }
}
