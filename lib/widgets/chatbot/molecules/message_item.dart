import 'package:bigagent/models/message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
          if (isBot)
            CachedNetworkImage(
              imageUrl: participantImage,
              imageBuilder: (context, imageProvider) => Container(
                width: 40.0,
                height: 40.0,
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
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
                  Text(
                    message.content,
                    style: theme.textTheme.bodyMedium,
                    textAlign: isBot ? TextAlign.start : TextAlign.end,
                    overflow: TextOverflow.visible,
                  ),
                if (message.isLoading)
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          if (!isBot)
            CachedNetworkImage(
              imageUrl: participantImage,
              imageBuilder: (context, imageProvider) => Container(
                width: 40.0,
                height: 40.0,
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
