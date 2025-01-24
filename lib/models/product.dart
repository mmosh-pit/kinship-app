final class Product {
  final String productId;
  final String name;
  final int tier;
  final String price;
  final String agents;

  const Product({
    required this.productId,
    required this.name,
    required this.tier,
    required this.price,
    required this.agents,
  });

  Product.fromJson(Map<String, dynamic> json)
      : this(
          productId: json['product_id'] ?? '',
          name: json['name'] ?? "",
          tier: json['tier'] ?? 0,
          price: "",
          agents: json["agents"] ?? "",
        );

  Product copyWith({
    String? price,
  }) =>
      Product(
        productId: productId,
        name: name,
        tier: tier,
        price: price ?? this.price,
        agents: agents,
      );
}
