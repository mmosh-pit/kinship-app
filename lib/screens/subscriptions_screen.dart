import 'package:bigagent/widgets/subscriptions/organisms/subscriptions_list.dart';
import 'package:flutter/material.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 20,
          children: [
            Row(
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
                    "2 Agents",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Text(
                  "•",
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  "Introductory",
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SubscriptionsList(),
          ],
        ),
      ),
    );
  }
}
