import 'package:flutter/material.dart';

import '../../screens/main/no_network_screen.dart';
import '../../screens/main/no_notifications_screen.dart';
import '../../screens/main/no_products_screen.dart';
import '../../screens/main/no_videos_screen.dart';

class AppRoutes {
  static const noNotifications = '/no-notifications';
  static const noNetwork = '/no-network';
  static const noVideos = '/no-videos';
  static const noProducts = '/no-products';

  static Map<String, WidgetBuilder> get routes => {
        noNotifications: (_) => const NoNotificationsScreen(),
        noNetwork: (_) => const NoNetworkScreen(),
        noVideos: (_) => const NoVideosScreen(),
        noProducts: (_) => const NoProductsScreen(),
      };

  static Future<T?> pushNoNotifications<T>(BuildContext context) {
    return Navigator.of(context).pushNamed<T>(noNotifications);
  }

  static Future<T?> pushNoNetwork<T>(BuildContext context) {
    return Navigator.of(context).pushNamed<T>(noNetwork);
  }

  static Future<T?> pushNoVideos<T>(BuildContext context) {
    return Navigator.of(context).pushNamed<T>(noVideos);
  }

  static Future<T?> pushNoProducts<T>(BuildContext context) {
    return Navigator.of(context).pushNamed<T>(noProducts);
  }
}
