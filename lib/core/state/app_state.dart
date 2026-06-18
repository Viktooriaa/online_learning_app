import 'package:flutter/foundation.dart';

/// Глобальний стан додатку (демо без backend).
class AppState {
  AppState._();

  static final ValueNotifier<bool> purchaseCompleted = ValueNotifier(false);

  static void completePurchase() {
    purchaseCompleted.value = true;
  }
}
