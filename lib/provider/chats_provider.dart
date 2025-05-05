import 'dart:async';

import 'package:kinship_bots/models/chat.dart';
import 'package:kinship_bots/services/chat_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsProvider extends AsyncNotifier<List<Chat>> {
  Future<List<Chat>> _getChats() async {
    try {
      final response = await ChatService.getChats();

      return response;
    } catch (err) {
      return [];
    }
  }

  @override
  FutureOr<List<Chat>> build() {
    return _getChats();
  }
}

final asyncChatsProvider = AsyncNotifierProvider<ChatsProvider, List<Chat>>(() {
  return ChatsProvider();
});
