import 'package:kinship_bots/widgets/chats/molecules/search_text_field.dart';
import 'package:kinship_bots/widgets/chats/organisms/chats_list.dart';
import 'package:flutter/material.dart';

class ChatsListWrapper extends StatelessWidget {
  const ChatsListWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [SearchTextField(), ChatsList()]);
  }
}
