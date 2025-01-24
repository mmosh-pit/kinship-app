import 'dart:async';

import 'package:bigagent/models/product.dart';
import 'package:bigagent/models/store_state.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class Purchases {
  final StoreState storeState;
  final StreamSubscription<List<PurchaseDetails>> subscription;
  final List<Product> products;

  Purchases({
    required this.storeState,
    required this.subscription,
    required this.products,
  });
}
