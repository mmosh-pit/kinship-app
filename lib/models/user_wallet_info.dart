class UserWalletInfo {
  List<BagsNFT> profiles;
  List<BagsNFT> passes;
  List<BagsNFT> badges;
  BagsCoins coins;

  UserWalletInfo({
    required this.profiles,
    required this.passes,
    required this.badges,
    required this.coins,
  });

  factory UserWalletInfo.fromJson(Map<String, dynamic> json) {
    return UserWalletInfo(
      profiles:
          List<BagsNFT>.from(json['profiles'].map((x) => BagsNFT.fromJson(x))),
      passes:
          List<BagsNFT>.from(json['passes'].map((x) => BagsNFT.fromJson(x))),
      badges:
          List<BagsNFT>.from(json['badges'].map((x) => BagsNFT.fromJson(x))),
      coins: json["coins"],
    );
  }
}

class BagsCoin {
  String image;
  String tokenAddress;
  String name;
  String symbol;
  double balance;
  int decimals;
  String? parentKey;

  BagsCoin({
    required this.image,
    required this.tokenAddress,
    required this.name,
    required this.symbol,
    required this.balance,
    required this.decimals,
    this.parentKey,
  });

  factory BagsCoin.fromJson(Map<String, dynamic> json) {
    return BagsCoin(
      image: json['image'] as String,
      tokenAddress: json['tokenAddress'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      balance: (json['balance'] as num).toDouble(),
      decimals: json['decimals'] as int,
      parentKey: json['parentKey'] as String?,
    );
  }
}

class BagsCoins {
  BagsCoin? network;
  BagsCoin? stable;
  BagsCoin? native;
  List<BagsCoin> community;
  List<BagsCoin> memecoins;

  BagsCoins({
    this.network,
    this.stable,
    this.native,
    required this.community,
    required this.memecoins,
  });

  factory BagsCoins.fromJson(Map<String, dynamic> json) {
    return BagsCoins(
      network:
          json['network'] != null ? BagsCoin.fromJson(json['network']) : null,
      stable: json['stable'] != null ? BagsCoin.fromJson(json['stable']) : null,
      native: json['native'] != null ? BagsCoin.fromJson(json['native']) : null,
      community: List<BagsCoin>.from(
          json['community'].map((x) => BagsCoin.fromJson(x))),
      memecoins: List<BagsCoin>.from(
          json['memecoins'].map((x) => BagsCoin.fromJson(x))),
    );
  }
}

class BagsNFT {
  String image;
  String tokenAddress;
  String name;
  String symbol;
  double balance;
  Map<String, dynamic> metadata;
  String? parentKey;

  BagsNFT({
    required this.image,
    required this.tokenAddress,
    required this.name,
    required this.symbol,
    required this.balance,
    required this.metadata,
    this.parentKey,
  });

  factory BagsNFT.fromJson(Map<String, dynamic> json) {
    return BagsNFT(
      image: json['image'] as String,
      tokenAddress: json['tokenAddress'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      balance: (json['balance'] as num).toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>,
      parentKey: json['parentKey'] as String?,
    );
  }
}
