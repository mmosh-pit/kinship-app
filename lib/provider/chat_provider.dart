import 'package:ai_app/models/chat.dart';
import 'package:ai_app/models/message.dart';
import 'package:ai_app/services/chat_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatProvider extends AsyncNotifier<Chat> {
  Future<Chat> _getChat() async {
    try {
      final response = await ChatService.getChat();

      return response;
    } catch (_) {
      return Chat.empty();
    }
  }

  @override
  Future<Chat> build() async {
    return _getChat();
  }

  void addMessage(Message message) {
    if (message.type == "bot") {
      if (state.value!.messages.isEmpty) {
        state = AsyncValue.data(state.value!.addMessage(message));
        return;
      }

      final lastMessage = state.value!.messages.last;

      if (lastMessage.type == "bot") {
        final newMessage = lastMessage.copyWith(
          content: lastMessage.content + message.content,
          isLoading: false,
        );
        state = AsyncValue.data(state.value!.modifyLastMessage(newMessage));
        return;
      }

      state = AsyncValue.data(state.value!.addMessage(message));

      return;
    }
    state = AsyncValue.data(state.value!.addMessage(message));
    state = AsyncValue.data(
      state.value!.addMessage(
        Message(
          id: "",
          content: "",
          type: "bot",
          sender: "",
          isLoading: true,
        ),
      ),
    );
  }
}

final asyncChatProvider = AsyncNotifierProvider<ChatProvider, Chat>(() {
  return ChatProvider();
});
