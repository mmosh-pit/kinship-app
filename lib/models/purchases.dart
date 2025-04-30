import 'package:bigagent/models/product.dart';
import 'package:bigagent/models/store_state.dart';

class Purchases {
  final StoreState storeState;
  // final StreamSubscription<List<PurchaseDetails>> subscription;
  final List<Product> products;

  Purchases({
    required this.storeState,
    // required this.subscription,
    required this.products,
  });
}
