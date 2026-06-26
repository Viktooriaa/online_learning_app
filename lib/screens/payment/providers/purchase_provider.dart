import 'package:flutter_riverpod/flutter_riverpod.dart';

final purchaseProvider =
    NotifierProvider<PurchaseNotifier, bool>(PurchaseNotifier.new);

class PurchaseNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void complete() => state = true;
}
