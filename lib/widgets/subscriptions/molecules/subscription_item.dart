import 'dart:io';

import 'package:bigagent/provider/app_purchases_provider.dart';
import 'package:bigagent/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionItem extends StatelessWidget {
  final String name;
  final String price;
  final String agents;
  final String productId;
  final bool active;
  final bool upgrade;
  final ProductDetails? details;

  const SubscriptionItem({
    super.key,
    required this.name,
    required this.price,
    required this.agents,
    required this.productId,
    required this.active,
    required this.upgrade,
    required this.details,
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
                      agents == "0" ? "Unlimited" : "$agents agents",
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
              final isLoadingButton =
                  ref.watch(asyncAppPurchasesProvider).isLoading;

              return ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Color(
                          active
                              ? 0xFF3C00FF
                              : upgrade
                                  ? 0xFFFF00AE
                                  : 0xFFCC038C,
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Color(
                      active
                          ? 0xFF3C00FF
                          : upgrade
                              ? 0xFFFF00AE
                              : 0xFFFF00AE,
                    ).withValues(alpha: !upgrade && !active ? 0.22 : 1),
                  ),
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

                  final provider = ref.read(asyncAuthProvider);

                  final subscription = provider.value!.user!.subscription;

                  if (productId.isEmpty && subscription != null) {
                    if (Platform.isIOS) {
                      launchUrl(
                        Uri.parse(
                            "https://apps.apple.com/account/subscriptions"),
                      );
                      return;
                    }

                    launchUrl(
                      Uri.parse(
                          'https://play.google.com/store/account/subscriptions?sku=${subscription.productId}&package=com.kinship.bigagent'),
                    );

                    return;
                  }

                  if (details == null) return;

                  final id = provider.value!.user!.uuid;

                  ref.read(asyncAppPurchasesProvider.notifier).buy(
                        productId: productId,
                        userId: id,
                        isConsumable: false,
                        details: details!,
                      );
                },
                child: isLoadingButton
                    ? const CircularProgressIndicator()
                    : Text(
                        active
                            ? "Current"
                            : upgrade
                                ? "Upgrade"
                                : "Downgrade",
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
