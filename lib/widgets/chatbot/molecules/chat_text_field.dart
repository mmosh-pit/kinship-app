import 'package:ai_app/provider/chat_provider.dart';
import 'package:ai_app/provider/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatTextField extends ConsumerStatefulWidget {
  const ChatTextField({super.key});

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {
  final _controller = TextEditingController();

  bool _hasText = false;

  void _onChangeText() {
    if (_controller.text.isNotEmpty && !_hasText) {
      setState(() {
        _hasText = true;
      });

      return;
    }

    if (_controller.text.isEmpty && _hasText) {
      setState(() {
        _hasText = false;
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_onChangeText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(asyncChatProvider);
    final theme = Theme.of(context);

    final isLoading = provider.isLoading;
    final hasError = provider.hasError;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFBBBBBB).withValues(alpha: 0.21),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF06052D),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: TextField(
              enabled: !hasError || !isLoading,
              controller: _controller,
              onSubmitted: (value) {
                ref.read(socketProvider).sendMessage(
                    {"data": _controller.text, "event": "message"});
                _controller.clear();
              },
              style: theme.textTheme.bodySmall,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: hasError
                    ? "There was an error with the connection, please reload the app or contact support"
                    : "Ask Uncle Psy and Aunt Bea",
                hintStyle:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.white60),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(socketProvider)
                  .sendMessage({"data": _controller.text, "event": "message"});
              _controller.clear();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                _hasText ? Colors.white : const Color(0xFF565656),
              ),
            ),
            child: isLoading
                ? const CircularProgressIndicator()
                : const Icon(
                    Icons.arrow_upward_outlined,
                    color: Color(0xFF050338),
                  ),
          )
        ],
      ),
    );
  }
}
