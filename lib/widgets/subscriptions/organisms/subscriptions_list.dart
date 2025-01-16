import 'package:bigagent/widgets/subscriptions/molecules/subscription_item.dart';
import 'package:flutter/material.dart';

const subscriptions = [
  {
    "name": "Introductory",
    "price": "Free",
    "agents": "2",
    "active": true,
  },
  {
    "name": "Intensive",
    "price": "\$7.99/mo",
    "agents": "5",
    "active": false,
  },
  {
    "name": "Immersive",
    "price": "\$29.99/mo",
    "agents": "25",
    "active": false,
  },
  {
    "name": "Expansive",
    "price": "\$49.99/mo",
    "agents": "0",
    "active": false,
  },
];

class SubscriptionsList extends StatelessWidget {
  const SubscriptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: subscriptions.length,
        itemBuilder: (_, index) {
          final item = subscriptions[index] as dynamic;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SubscriptionItem(
              name: item["name"],
              price: item["price"],
              agents: item["agents"],
              active: item["active"],
            ),
          );
        },
      ),
    );
  }
}
