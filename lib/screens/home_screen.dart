import 'package:bigagent/provider/auth_provider.dart';
import 'package:bigagent/provider/chat_provider.dart';
import 'package:bigagent/provider/socket_provider.dart';
import 'package:bigagent/provider/solana_provider.dart';
import 'package:bigagent/widgets/chatbot/molecules/chatbot_header.dart';
import 'package:bigagent/widgets/chatbot/molecules/home_header.dart';
import 'package:bigagent/widgets/chatbot/organisms/chatbot_messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _profileImage = "";
  String _guestProfileImage = "";

  String _participantName = "";

  void _fetchWalletData() async {
    final user = ref.read(asyncAuthProvider).value!.user;

    await ref
        .read(asyncSolanaProvider.notifier)
        .fetchUserWalletInfoData(user!.address);

    final data = ref.read(asyncSolanaProvider).value;

    if (data != null) {
      for (var e in data.profiles) {
        _profileImage = e.image;
        _participantName = e.name;
      }
    }

    final chat = ref.read(asyncChatProvider).value;

    if (_profileImage.isEmpty) {
      if (chat != null) {
        for (var e in chat.participants) {
          if (e.type == "user") {
            _guestProfileImage = e.picture;

            if (_participantName.isEmpty) {
              _participantName = e.name;
            }
          }
        }
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    ref.read(socketProvider).initialize();
    _fetchWalletData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                HomeHeader(profileImage: _profileImage),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF181747),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: MediaQuery.sizeOf(context).height * 0.80,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Column(
                        children: [
                          const ChatbotHeader(),
                          ChatbotMessagesList(
                            profileImage: _profileImage,
                            guestProfileImage: _guestProfileImage,
                            participantName: _participantName,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
