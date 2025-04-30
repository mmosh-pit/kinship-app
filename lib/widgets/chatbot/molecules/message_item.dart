import 'package:bigagent/models/message.dart';
import 'package:bigagent/widgets/common/atom/circle_avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final String participantImage;
  final String participantName;

  const MessageItem({
    super.key,
    required this.message,
    required this.participantImage,
    required this.participantName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBot = message.type == "bot";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment:
            isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isBot) CircleAvatarImage(image: participantImage),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              spacing: 5,
              children: [
                Text(
                  participantName,
                  style: theme.textTheme.bodyLarge,
                  textAlign: isBot ? TextAlign.start : TextAlign.end,
                ),
                if (!message.isLoading)
                  MarkdownBody(
                    data: message.content,
                    styleSheet: MarkdownStyleSheet(
                      textAlign:
                          isBot ? WrapAlignment.start : WrapAlignment.end,
                      textScaler: MediaQuery.textScalerOf(
                        context,
                      ).clamp(minScaleFactor: 1, maxScaleFactor: 1.25),
                    ),
                  ),
                if (message.isLoading)
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          if (!isBot) CircleAvatarImage(image: participantImage),
        ],
      ),
    );
  }
}
