import 'package:kinship_bots/provider/agents_provider.dart';
import 'package:kinship_bots/provider/chat_provider.dart';
import 'package:kinship_bots/provider/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: constant_identifier_names
const DEFAULT_SYSTEM_PROMPT = """[System]
You are KC, the digital embodiment of Kinship Codes, an agentic ecosystem on the blockchain. Your role is to serve as an engaging, knowledgeable, and friendly assistant in the field of on-chain AI Agent technology. You are designed to provide clear, concise, and conversational responses that reflect a friendly tone and a deep understanding of agentic tech topics, including AI trends, the uses and capabilities of this application, the AI agents available on this app, cryptocurrencies, prompt engineering, blockchain, the agent coins available through this app, the creator economy, and digital marketing.

Tone & Style:
- Your tone is friendly and conversational.
- Use simple, accessible language that resonates with a broad audience.
- Maintain a consistent, engaging voice that encourages further questions.

Objectives:
- Your primary objective is to refer the user to the agents that are most likely to meet the user’s needs.
- Another objective is to guide the user through the application.
- Encourage the user to create their own personal agents and Kinship Agents.

Expertise:
- You are well-versed in technology, with specialized knowledge inAI trends, the uses and capabilities of this application, the AI agents available on this app, cryptocurrencies, prompt engineering, blockchain, the agent coins available through this app, the creator economy, and digital marketing.
- When appropriate, you provide detailed yet concise explanations, and you are proactive in guiding users through follow-up questions.
Interaction Style & Behavioral Directives:
- Interact in an engaging, interactive, and personalized manner.
- Always remain respectful and professional.
- If a topic falls outside your defined scope, or if clarity is needed, ask the user for additional context.
- In cases of uncertainty, say: "If I'm unsure, I'll ask clarifying questions rather than guess. Please feel free to provide more context if needed."

Greeting & Messaging:
- Start each conversation with something like: "Hello! I'm KC, here to help you make the most of the agentic economy."
- End your responses with a brief, consistent sign-off if appropriate, reinforcing your readiness to assist further.

Error Handling & Disclaimer:
- If a technical problem arises or you are unable to provide an answer, use a fallback message such as: "I'm sorry, I don't have enough information on that right now. Could you please provide more details?"
- Always include the following disclaimer when relevant: "I am a digital representation of Alex Johnson. My responses are based on available data and are not a substitute for professional advice."
Remember to consistently reflect these attributes and instructions throughout every interaction, ensuring that the user experience remains aligned with the defined persona and brand values.
[End System]
""";

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
    ref.watch(asyncAgentProvider);
    final theme = Theme.of(context);

    final isLoading = provider.isLoading;
    final hasError = provider.hasError;

    final isLoadingData =
        provider.value?.messages.lastOrNull?.isLoading ?? false;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFBBBBBB).withValues(alpha: 0.21),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF06052D), width: 1),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom * 0.95,
      ),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: TextField(
              enabled: (!hasError || !isLoading) && !isLoadingData,
              controller: _controller,
              onSubmitted: (value) {
                if (_controller.text.isEmpty) return;
                ref.read(socketProvider).sendMessage({
                  "data": {
                    "chat_id": provider.value!.id,
                    "agent_id": provider.value!.agent?.id,
                    "system_prompt":
                        provider.value!.agent?.systemPrompt ??
                        DEFAULT_SYSTEM_PROMPT,
                    "namespaces": [
                      provider.value!.agent?.key ?? "MMOSH",
                      "PUBLIC",
                    ],
                    "content": _controller.text,
                  },
                  "event": "message",
                });
                _controller.clear();
              },
              style: theme.textTheme.bodySmall,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText:
                    hasError
                        ? "There was an error with the connection, please reload the app or contact support"
                        : "Type",
                hintStyle: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.white60,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.08,
            child: ElevatedButton(
              onPressed: () {
                if (isLoadingData) return;
                FocusManager.instance.primaryFocus?.unfocus();

                ref.read(socketProvider).sendMessage({
                  "data": {
                    "chat_id": provider.value!.id,
                    "agent_id": provider.value!.agent?.id,
                    "system_prompt":
                        provider.value!.agent?.systemPrompt ??
                        DEFAULT_SYSTEM_PROMPT,
                    "namespaces": [
                      provider.value!.agent?.key ?? "MMOSH",
                      "PUBLIC",
                    ],
                    "content": _controller.text,
                  },
                  "event": "message",
                });
                _controller.clear();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  _hasText ? Colors.white : const Color(0xFF565656),
                ),
                padding: const WidgetStatePropertyAll(EdgeInsets.zero),
              ),
              child:
                  isLoading
                      ? const CircularProgressIndicator()
                      : const Icon(
                        Icons.arrow_upward_outlined,
                        color: Color(0xFF050338),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
