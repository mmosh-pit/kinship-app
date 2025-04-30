import 'package:bigagent/provider/auth_provider.dart';
import 'package:bigagent/provider/socket_provider.dart';
import 'package:bigagent/provider/solana_provider.dart';
import 'package:bigagent/widgets/chats/templates/chats_list_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _fetchWalletData() async {
    final user = ref.read(asyncAuthProvider).value!.user;

    await ref
        .read(asyncSolanaProvider.notifier)
        .fetchUserWalletInfoData(user!.address);
  }

  @override
  void initState() {
    ref.read(socketProvider).initialize();
    _fetchWalletData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const ChatsListWrapper();
  }
}
