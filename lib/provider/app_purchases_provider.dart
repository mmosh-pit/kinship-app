import 'dart:async';
import 'package:bigagent/models/product.dart';
import 'package:bigagent/models/purchasable_product.dart';
import 'package:bigagent/models/purchases.dart';
import 'package:bigagent/models/store_state.dart';
import 'package:bigagent/utils/dio_client.dart';
import 'package:bigagent/utils/in_app_connection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class AppPurchasesProvider extends AsyncNotifier<Purchases> {
  static final _client = DioClient();

  bool _activePayment = false;

  static final iapConnection = IAPConnection.instance;

  Future<Purchases> _getPurchases() async {
    try {
      final response = await _client.get('/subscriptions');
      if (response.statusCode == 200) {
        var result = <Product>[];
        final payload = response.data['data'] as List;

        result.addAll(payload.map((item) => Product.fromJson(item)));

        for (var item in result) {
          final product = await getProductById(item.productId);

          item = item.copyWith(price: product?.price);
        }

        final purchaseUpdated = iapConnection.purchaseStream;

        return Purchases(
          storeState: StoreState.available,
          subscription: purchaseUpdated.listen(
            _onPurchaseUpdate,
            onDone: _updateStreamOnDone,
            onError: _updateStreamOnError,
          ),
          products: result,
        );
      } else {
        throw Exception('Error on obtaining products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error on get products request: $e');
    }
  }

  @override
  Future<Purchases> build() async {
    return _getPurchases();
  }

  Future<PurchasableProduct?> getProductById(String productId) async {
    Set<String> productIds = {productId};
    final response = await iapConnection.queryProductDetails(productIds);

    if (response.productDetails.isEmpty) return null;

    return PurchasableProduct(response.productDetails.first);
  }

  Future<void> buy({
    required String productId,
    required String userId,
    required bool isConsumable,
  }) async {
    final response = await iapConnection.queryProductDetails({productId});

    if (response.productDetails.isEmpty) return;
    _activePayment = true;
    final purchaseParam = PurchaseParam(
      productDetails: response.productDetails.first,
      applicationUserName: userId,
    );
    if (isConsumable) {
      await iapConnection.buyConsumable(purchaseParam: purchaseParam);
    } else {
      try {
        await iapConnection.buyNonConsumable(purchaseParam: purchaseParam);
      } on PlatformException catch (err) {
        debugPrint(
            "Got error here: $err, code: ${err.code}, details: ${err.details}");
      }
    }
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    iapConnection.completePurchase(purchaseDetails);
    if (purchaseDetails.status == PurchaseStatus.canceled) {
      return;
    }

    if (purchaseDetails.pendingCompletePurchase) {
      if (_activePayment) {
        _activePayment = false;
      }
    }

    if (purchaseDetails.status == PurchaseStatus.canceled) {
      await iapConnection.completePurchase(purchaseDetails);
    }
  }

  void _updateStreamOnDone() {
    state.value!.subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    debugPrint("Error in app_purchases_provider: $error");
  }
}

final asyncAppPurchasesProvider =
    AsyncNotifierProvider<AppPurchasesProvider, Purchases>(
  () => AppPurchasesProvider(),
);
