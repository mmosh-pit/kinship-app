import 'package:bigagent/models/product.dart';
import 'package:bigagent/provider/app_purchases_provider.dart';
import 'package:bigagent/provider/auth_provider.dart';
import 'package:bigagent/widgets/subscriptions/molecules/subscription_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final defaultSubscription = Product.fromJson({
  "name": "Introductory",
  "price": "Free",
  "agents": "2",
  "active": true,
});

class SubscriptionsList extends ConsumerWidget {
  const SubscriptionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(asyncAppPurchasesProvider);

    final authProvider = ref.watch(asyncAuthProvider);

    if (provider.value == null) return const Placeholder();

    final subscriptions = provider.value!.products;

    final activeSubscription =
        authProvider.value!.user!.subscription!.productId;

    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          SubscriptionItem(
            name: defaultSubscription.name,
            price: defaultSubscription.price,
            agents: defaultSubscription.agents,
            active: activeSubscription.isEmpty,
          ),
          ...subscriptions.map(
            (item) => SubscriptionItem(
              name: item.name,
              price: item.price,
              agents: item.agents,
              active: item.productId == activeSubscription,
            ),
          ),
        ],
      ),
    );
  }
}
