import 'dart:async';
import 'dart:developer';

import 'package:bigagent/models/user_wallet_info.dart';
import 'package:bigagent/provider/agents_provider.dart';
import 'package:bigagent/services/helius_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod/riverpod.dart';

final communityPtvbCoin = dotenv.env["PTVB_TOKEN"];
final communityPtvrCoin = dotenv.env["PTVR_TOKEN"];

const passCollection = "PASSES";
const badgeCollection = "BADGES";
const profileCollection = "PROFILES";

class SolanaProvider extends AsyncNotifier<UserWalletInfo?> {
  Future<Set<String>> _getAllTokenAddreses() async {
    Set<String> tokens = {};

    final response = await HeliusService.getAllTokenAddreses();

    for (final address in response) {
      tokens.add(address);
    }

    return tokens;
  }

  Future<void> fetchUserWalletInfoData(String wallet) async {
    final allTokens = await _getAllTokenAddreses();

    final response = await HeliusService.fetchWalletData(wallet);

    List<BagsCoin> communityCoins = [];
    List<BagsCoin> memecoins = [];

    List<BagsNFT> badges = [];
    List<BagsNFT> profiles = [];
    List<BagsNFT> passes = [];

    for (final value in response["result"]["items"]) {
      if (value["interface"] == "FungibleToken") {
        if (value["token_info"]["decimals"] > 0) {
          final coin = {
            "name": value["content"]["metadata"]["name"],
            "image": value["content"]["links"]["image"] ?? "",
            "symbol": value["content"]["metadata"]["symbol"],
            "balance": value["token_info"]["balance"],
            "tokenAddress": value["id"],
            "decimals": value["token_info"]["decimals"],
          };

          if (value["id"] == communityPtvbCoin ||
              value["id"] == communityPtvrCoin) {
            communityCoins.add(BagsCoin.fromJson(coin));
          } else if (allTokens.contains(value["id"])) {
            memecoins.add(BagsCoin.fromJson(coin));
          }
        } else {
          final badge = {
            "name": value["content"]["metadata"]["name"],
            "image": value["content"]["links"]["image"] ?? "",
            "symbol": value["content"]["metadata"]["symbol"],
            "balance": value["token_info"]["balance"],
            "tokenAddress": value["id"],
            "metadata": value["content"]["metadata"],
          };

          if (value["group_definition"] != null &&
              value["group_definition"]?.length > 0) {
            final collectionDefinition = value["grouping"].firstWhere(
              (e) => e["group_key"] == "collection",
            );

            if (collectionDefinition?["collection_metadata"]?["symbol"] ==
                badgeCollection) {
              badges.add(BagsNFT.fromJson(badge));
            }
          }
        }
        continue;
      }

      final nft = {
        "name": value["content"]["metadata"]["name"],
        "image": value["content"]["links"]["image"] ?? "",
        "symbol": value["content"]["metadata"]["symbol"],
        "balance": 1,
        "tokenAddress": value["id"],
        "metadata": value["content"]["metadata"],
      };

      final collectionDefinition = value["grouping"].firstWhere(
        (e) => e["group_key"] == "collection",
      );

      if (collectionDefinition?["collection_metadata"]?["symbol"] ==
          profileCollection) {
        profiles.add(BagsNFT.fromJson(nft));
        continue;
      }

      if (collectionDefinition["collection_metadata"]["symbol"] ==
          passCollection) {
        nft["parentKey"] = value["content"]["metadata"]["attributes"]
            ?.find(
              (attr) =>
                  attr["trait_type"] == "Community" ||
                  attr["trait_type"] == "Project",
            )
            ?.value;

        passes.add(BagsNFT.fromJson(nft));
        continue;
      }
    }

    state = AsyncValue.data(
      UserWalletInfo(
        profiles: profiles,
        passes: passes,
        badges: badges,
        coins: BagsCoins(
          community: communityCoins,
          memecoins: memecoins,
        ),
      ),
    );

    ref.read(asyncAgentProvider.notifier).setupAvailableAgents();
  }

  @override
  FutureOr<UserWalletInfo?> build() {
    return null;
  }
}

final asyncSolanaProvider =
    AsyncNotifierProvider<SolanaProvider, UserWalletInfo?>(
  () => SolanaProvider(),
);
