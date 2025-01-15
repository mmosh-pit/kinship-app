import 'package:bigagent/provider/chat_provider.dart';
import 'package:bigagent/provider/socket_provider.dart';
import 'package:bigagent/widgets/chatbot/molecules/chat_text_field.dart';
import 'package:bigagent/widgets/chatbot/molecules/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatbotMessagesList extends ConsumerStatefulWidget {
  final String profileImage;
  final String guestProfileImage;
  final String participantName;

  const ChatbotMessagesList({
    super.key,
    required this.profileImage,
    required this.guestProfileImage,
    required this.participantName,
  });

  @override
  ConsumerState<ChatbotMessagesList> createState() =>
      _ChatbotMessagesListState();
}

class _ChatbotMessagesListState extends ConsumerState<ChatbotMessagesList> {
  final _scrollController = ScrollController();
  int _messagesLength = 0;

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ref.watch(socketStreamProvider);

    return Expanded(
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
                  final chat = ref.watch(asyncChatProvider).value;

                  if (chat == null) {
                    return const Placeholder();
                  }

                  if (chat.messages.length > _messagesLength) {
                    _messagesLength = chat.messages.length;
                    _scrollToBottom();
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    itemBuilder: (_, index) {
                      final isBot = chat.messages[index].type == "bot";

                      final userImage = widget.profileImage.isNotEmpty
                          ? widget.profileImage
                          : widget.guestProfileImage;

                      final botUser = chat.participants.firstWhere(
                        (e) => e.id == chat.messages[index].sender,
                      );

                      final botImage = botUser.picture;
                      final botName = botUser.name;

                      final participantImage = !isBot ? userImage : botImage;
                      final name = !isBot ? widget.participantName : botName;

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
      ),
    );
  }
}
