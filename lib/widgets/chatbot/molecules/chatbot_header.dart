import 'package:kinship_bots/provider/chat_provider.dart';
import 'package:kinship_bots/widgets/chats/molecules/chat_expandable_search.dart';
import 'package:kinship_bots/widgets/common/atom/circle_avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ChatbotHeader extends ConsumerWidget {
  const ChatbotHeader({super.key});

  final _defaultImage =
      "https://storage.googleapis.com/mmosh-assets/ks_logo.png";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final provider = ref.watch(asyncChatProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              GestureDetector(
                onTap: () {
                  ref.read(asyncChatProvider.notifier).clearChat();
                  GoRouter.of(context).pop();
                },

                child: const Icon(Icons.chevron_left, color: Colors.white),
              ),

              CircleAvatarImage(
                image: provider.value!.agent?.image ?? _defaultImage,
              ),

              Text(
                "@${provider.value!.agent?.symbol ?? 'kinship'}",
                style: theme.textTheme.titleMedium,
              ),

              provider.value!.agent?.type == "personal"
                  ? SvgPicture.asset("assets/icons/personal_agent.svg")
                  : SvgPicture.asset("assets/icons/kinship_agent.svg"),
            ],
          ),

          const Spacer(),

          const ChatExpandableSearch(),
        ],
      ),
    );
  }
}
