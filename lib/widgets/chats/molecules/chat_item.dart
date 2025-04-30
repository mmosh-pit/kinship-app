import 'package:bigagent/models/chat.dart';
import 'package:bigagent/provider/chat_provider.dart';
import 'package:bigagent/utils/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatItem extends ConsumerWidget {
  final Chat chat;

  const ChatItem({super.key, required this.chat});

  String _getMessageDate(String dateTime) {
    return DateFormat.jm().format(DateTime.parse(dateTime).toLocal());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        ref.read(asyncChatProvider.notifier).setChat(chat);
        GoRouter.of(context).push(Routes.chatRoute);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          CachedNetworkImage(
            imageUrl:
                chat.agent?.image ??
                "https://storage.googleapis.com/mmosh-assets/ks_logo.png",
            imageBuilder: (_, image) => CircleAvatar(backgroundImage: image),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    "@${chat.agent?.symbol ?? 'kinship'}",
                    style: theme.textTheme.titleSmall,
                  ),

                  chat.agent?.type == "personal"
                      ? SvgPicture.asset("assets/icons/personal_agent.svg")
                      : SvgPicture.asset("assets/icons/kinship_agent.svg"),
                ],
              ),
              if (chat.lastMessage != null)
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.50,
                  child: Text(
                    chat.lastMessage!.content,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          const Spacer(),

          if (chat.lastMessage != null)
            Text(
              _getMessageDate(chat.lastMessage!.createdAt),
              style: theme.textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }
}
