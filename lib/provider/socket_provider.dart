import 'package:bigagent/provider/chat_provider.dart';
import 'package:bigagent/services/socket_service.dart';
import 'package:riverpod/riverpod.dart';

final socketProvider = Provider<SocketService>((ref) {
  return SocketService();
});

final socketStreamProvider = StreamProvider((ref) async* {
  final streamData = ref.watch(socketProvider).getMessagesData();

  await for (final message in streamData) {
    ref.read(asyncChatProvider.notifier).addMessage(message);
  }
});
