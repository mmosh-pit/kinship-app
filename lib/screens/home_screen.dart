import 'package:ai_app/provider/auth_provider.dart';
import 'package:ai_app/provider/chat_provider.dart';
import 'package:ai_app/provider/socket_provider.dart';
import 'package:ai_app/provider/solana_provider.dart';
import 'package:ai_app/widgets/chatbot/molecules/chat_text_field.dart';
import 'package:ai_app/widgets/chatbot/molecules/message_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _profileImage = "";

  void _fetchWalletData() async {
    final user = ref.read(asyncAuthProvider).value!.user;

    await ref
        .read(asyncSolanaProvider.notifier)
        .fetchUserWalletInfoData(user!.address);

    final data = ref.read(asyncSolanaProvider).value;

    if (data != null) {
      for (var e in data.profiles) {
        _profileImage = e.image;
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
    final theme = Theme.of(context);
    ref.watch(socketStreamProvider);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/kinship_main_icon.svg",
                        height: 50,
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          if (_profileImage.isNotEmpty)
                            CachedNetworkImage(
                              imageUrl: _profileImage,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 40.0,
                                height: 40.0,
                                margin: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFD858BC),
                                  Color(0xFF3C00FF),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Consumer(
                              builder: (_, ref, __) => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  ref.read(asyncAuthProvider.notifier).logout();
                                },
                                child: Text(
                                  "Log Out",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF181747),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: MediaQuery.sizeOf(context).height * 0.80,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF030234),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 5,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      "https://storage.googleapis.com/mmosh-assets/uncle-psy.png",
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      "https://storage.googleapis.com/mmosh-assets/opos-logo.png",
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      "https://storage.googleapis.com/mmosh-assets/aunt-bea.png",
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  spacing: 5,
                                  children: [
                                    Text(
                                      "Ask Uncle Psy and Aunt Bea",
                                      style: theme.textTheme.headlineSmall,
                                    ),
                                    Text(
                                      "the Composable Opossums",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Consumer(
                                    builder: (_, ref, __) {
                                      final chat =
                                          ref.watch(asyncChatProvider).value;

                                      if (chat == null) {
                                        return const Placeholder();
                                      }

                                      return ListView.builder(
                                        itemBuilder: (_, index) => MessageItem(
                                          key: Key(chat.messages[index].id),
                                          message: chat.messages[index],
                                          participantImage: _profileImage,
                                        ),
                                        shrinkWrap: true,
                                        itemCount: chat.messages.length,
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.viewInsetsOf(context)
                                          .bottom),
                                  child: const ChatTextField(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
