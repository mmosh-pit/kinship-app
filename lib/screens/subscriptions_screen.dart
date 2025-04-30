import 'package:bigagent/provider/auth_provider.dart';
import 'package:bigagent/widgets/subscriptions/organisms/subscriptions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.75,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 20,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final authProvider = ref.watch(asyncAuthProvider);
                final activeSubscription =
                    authProvider.value!.user!.subscription!;

                return Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3C00FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        "${activeSubscription.agents.isEmpty ? '1' : activeSubscription.agents} Agents",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      "•",
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      activeSubscription.name.isEmpty
                          ? "Introductory"
                          : activeSubscription.name,
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                );
              },
            ),
            const SubscriptionsList(),
          ],
        ),
      ),
    );
  }
}
