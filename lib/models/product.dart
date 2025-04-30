import 'package:in_app_purchase/in_app_purchase.dart';

final class Product {
  final String productId;
  final String name;
  final int tier;
  final String price;
  final String agents;
  final ProductDetails? details;

  const Product({
    required this.productId,
    required this.name,
    required this.tier,
    required this.price,
    required this.agents,
    this.details,
  });

  Product.fromJson(Map<String, dynamic> json)
      : this(
          productId: json['product_id'] ?? '',
          name: json['name'] ?? "",
          tier: json['tier'] ?? 0,
          price: json["price"] ?? "",
          agents: json["agents"] ?? "",
        );

  factory Product.fromUserJson(Map<String, dynamic> json) {
    return Product(
      price: "",
      productId: json["product_id"],
      tier: json["subscription_tier"],
      agents: "",
      name: "",
    );
  }

  Product copyWith({
    String? price,
    String? agents,
    ProductDetails? details,
  }) =>
      Product(
        productId: productId,
        name: name,
        tier: tier,
        price: price ?? this.price,
        agents: agents ?? this.agents,
        details: details ?? this.details,
      );

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "name": name,
      "tier": tier,
      "price": price,
      "agents": agents,
    };
  }
}
