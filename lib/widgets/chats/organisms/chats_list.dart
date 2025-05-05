import 'package:kinship_bots/provider/chats_provider.dart';
import 'package:kinship_bots/widgets/chats/molecules/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsList extends ConsumerWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(asyncChatsProvider).value;

    if (chats == null) return const SizedBox.shrink();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        shrinkWrap: true,
        itemBuilder:
            (_, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ChatItem(chat: chats[index]),
            ),
        itemCount: chats.length,
      ),
    );
  }
}
