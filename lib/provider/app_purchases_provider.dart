import 'dart:async';
import 'package:kinship_bots/models/purchases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppPurchasesProvider extends AsyncNotifier<Purchases?> {
  // static final _client = DioClient();

  // bool _activePayment = false;
  //
  // ProductDetails? _activeDetails;
  //
  // final List<ProductDetails> _products = [];

  // static final iapConnection = IAPConnection.instance;

  Future<Purchases?> _getPurchases() async {
    try {
      // final response = await _client
      //     .get('/subscriptions?platform=${Platform.isIOS ? "ios" : "android"}');
      // if (response.statusCode == 200) {
      //   var result = <Product>[];
      //   final payload = response.data['data'] as List;
      //
      //   for (var item in payload) {
      //     final parsedProduct = Product.fromJson(item);
      //     final product = await getProductById(parsedProduct.productId);
      //
      //     if (Platform.isIOS) {
      //       result.add(
      //         parsedProduct.copyWith(
      //             price: product?.price, details: product!.productDetails),
      //       );
      //     } else {
      //       result.add(
      //         parsedProduct.copyWith(price: product?.price),
      //       );
      //     }
      //   }
      //
      //   final purchaseUpdated = iapConnection.purchaseStream;
      //
      //   ref.read(asyncAuthProvider.notifier).updateCurrentProductAgent(result);
      //
      //   var index = 0;
      //
      //   if (Platform.isAndroid) {
      //     for (final product in _products) {
      //       result[index] =
      //           result[index].copyWith(details: product, price: product.price);
      //       index++;
      //     }
      //   }
      //
      //   return Purchases(
      //     storeState: StoreState.available,
      //     subscription: purchaseUpdated.listen(
      //       _onPurchaseUpdate,
      //       onDone: _updateStreamOnDone,
      //       onError: _updateStreamOnError,
      //     ),
      //     products: result,
      //   );
      // } else {
      //   throw Exception('Error on obtaining products: ${response.statusCode}');
      // }
    } catch (e) {
      throw Exception('Error on get products request: $e');
    }
    return null;
  }

  @override
  Future<Purchases?> build() async {
    return _getPurchases();
  }

  // Future<PurchasableProduct?> getProductById(String productId) async {
  //   Set<String> productIds = {productId};
  //   final response = await iapConnection.queryProductDetails(productIds);
  //
  //   if (response.productDetails.isEmpty) return null;
  //   _products.addAll(response.productDetails);
  //
  //   return PurchasableProduct(response.productDetails.first);
  // }

  Future<void> buy({
    required String productId,
    required String userId,
    required bool isConsumable,
    // required ProductDetails details,
  }) async {
    // if (_activePayment) return;
    // state = const AsyncValue.loading();
    //
    // _activePayment = true;
    // final purchaseParam = PurchaseParam(
    //   productDetails: details,
    //   applicationUserName: userId,
    // );
    //
    // _activeDetails = details;
    //
    // if (isConsumable) {
    //   await iapConnection.buyConsumable(purchaseParam: purchaseParam);
    // } else {
    //   try {
    //     await iapConnection.buyNonConsumable(purchaseParam: purchaseParam);
    //   } on PlatformException catch (err) {
    //     debugPrint(
    //         "Got error here: $err, code: ${err.code}, details: ${err.details}");
    //   }
    // }
  }

  // Future<void> _onPurchaseUpdate(
  //     List<PurchaseDetails> purchaseDetailsList) async {
  //   for (var purchaseDetails in purchaseDetailsList) {
  //     await _handlePurchase(purchaseDetails);
  //   }
  // }

  // Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
  //   iapConnection.completePurchase(purchaseDetails);
  //   if (purchaseDetails.status == PurchaseStatus.canceled) {
  //     state = AsyncValue.data(state.value!);
  //     return;
  //   }
  //
  //   if (purchaseDetails.pendingCompletePurchase) {
  //     if (_activePayment) {
  //       _activePayment = false;
  //     }
  //
  //     try {
  //       if (Platform.isIOS) {
  //         final product = state.value!.products
  //             .firstWhere((e) => e.productId == purchaseDetails.productID);
  //
  //         ref.read(asyncAuthProvider.notifier).setUserSubscription(
  //               product,
  //             );
  //       } else {
  //         final product = state.value!.products
  //             .firstWhere((e) => e.price == _activeDetails?.price);
  //
  //         ref.read(asyncAuthProvider.notifier).setUserSubscription(
  //               product,
  //             );
  //       }
  //     } catch (_) {
  //       ref.read(asyncAuthProvider.notifier).setUserSubscription(
  //             null,
  //           );
  //     }
  //   }
  //
  //   state = AsyncValue.data(state.value!);
  // }

  // void _updateStreamOnDone() {
  //   state.value!.subscription.cancel();
  // }
  //
  // void _updateStreamOnError(dynamic error) {
  //   debugPrint("Error in app_purchases_provider: $error");
  // }
}

final asyncAppPurchasesProvider =
    AsyncNotifierProvider<AppPurchasesProvider, Purchases?>(
      () => AppPurchasesProvider(),
    );
