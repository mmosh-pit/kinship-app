import 'package:kinship_bots/provider/chat_provider.dart';
import 'package:kinship_bots/provider/socket_provider.dart';
import 'package:kinship_bots/provider/solana_provider.dart';
import 'package:kinship_bots/widgets/chatbot/molecules/chat_text_field.dart';
import 'package:kinship_bots/widgets/chatbot/molecules/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatbotMessagesList extends ConsumerStatefulWidget {
  const ChatbotMessagesList({super.key});

  @override
  ConsumerState<ChatbotMessagesList> createState() =>
      _ChatbotMessagesListState();
}

class _ChatbotMessagesListState extends ConsumerState<ChatbotMessagesList> {
  final _scrollController = ScrollController();

  String _profileImage =
      "https://storage.googleapis.com/mmosh-assets/avatar_placeholder.png";
  String _participantName = "You";

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  void initState() {
    final data = ref.read(asyncSolanaProvider).value;

    if (data != null) {
      for (var e in data.profiles) {
        _profileImage = e.image;
        _participantName = e.name;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(socketStreamProvider);
    // final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF181747),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Consumer(
              builder: (_, ref, __) {
                final chat = ref.watch(asyncChatProvider).value;

                if (chat == null) {
                  return const Placeholder();
                }

                Future.delayed(
                  const Duration(milliseconds: 10),
                  _scrollToBottom,
                );

                return ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (_, index) {
                    final isBot = chat.messages[index].type == "bot";

                    final botUser = chat.participants.firstWhere(
                      (e) => e.id == chat.messages[index].sender,
                    );

                    final botImage = botUser.picture;
                    final botName = botUser.name;

                    final participantImage = !isBot ? _profileImage : botImage;
                    final name = !isBot ? _participantName : botName;

                    return MessageItem(
                      key: Key(chat.messages[index].id),
                      message: chat.messages[index],
                      participantImage: participantImage,
                      participantName: name,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: chat.messages.length,
                );
              },
            ),
          ),
          const ChatTextField(),
        ],
      ),
    );
  }
}
