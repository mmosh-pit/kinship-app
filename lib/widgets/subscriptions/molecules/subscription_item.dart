import 'package:bigagent/provider/app_purchases_provider.dart';
import 'package:bigagent/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscriptionItem extends StatelessWidget {
  final String name;
  final String price;
  final String agents;
  final String productId;
  final bool active;

  const SubscriptionItem({
    super.key,
    required this.name,
    required this.price,
    required this.agents,
    required this.productId,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenDim = MediaQuery.sizeOf(context);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF191754).withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              SizedBox(
                width: screenDim.width * 0.25,
                child: Column(
                  spacing: 2,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: theme.textTheme.titleMedium),
                    Text(
                      agents == "0" ? "unlimited" : "$agents agents",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFFB5B5B5),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1858),
                  borderRadius: BorderRadius.circular(24),
                ),
                constraints: BoxConstraints(
                  minWidth: screenDim.width * 0.15,
                  maxWidth: screenDim.width * 0.20,
                  minHeight: screenDim.height * 0.03,
                ),
                child: Center(
                  child: Text(
                    price,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      // side: BorderSide(co)
                    ),
                  ),
                  // backgroundColor: WidgetStatePropertyAll(Color()),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 0,
                    ),
                  ),
                  fixedSize: WidgetStatePropertyAll(
                    Size.fromHeight(screenDim.height * 0.03),
                  ),
                ),
                onPressed: () {
                  if (active) return;

                  final id = ref.read(asyncAuthProvider).value!.user!.id;

                  ref.read(asyncAppPurchasesProvider.notifier).buy(
                        productId: productId,
                        userId: id,
                        isConsumable: false,
                      );
                },
                child: Text(
                  active ? "Current" : "Upgrade",
                  style: theme.textTheme.bodyMedium,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
