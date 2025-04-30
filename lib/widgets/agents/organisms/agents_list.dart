import 'package:bigagent/provider/agents_provider.dart';
import 'package:bigagent/widgets/agents/molecules/agent_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgentsList extends ConsumerStatefulWidget {
  const AgentsList({super.key});

  @override
  ConsumerState<AgentsList> createState() => _AgentsListState();
}

class _AgentsListState extends ConsumerState<AgentsList> {
  String? errorMessage;
  bool _isLoading = false;

  void _toggleActivate(String agentId) async {
    setState(() {
      _isLoading = true;
    });
    final result = await ref
        .read(asyncAgentProvider.notifier)
        .toggleActivatedAgent(agentId);

    if (result.isNotEmpty) {
      setState(() {
        errorMessage = result;
      });

      await Future.delayed(const Duration(seconds: 5));

      setState(() {
        errorMessage = null;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(asyncAgentProvider);

    final agents = provider.value?.agents ?? [];
    final activatedAgents = provider.value?.activatedAgents ?? {};

    return Expanded(
      child: Column(
        children: [
          if (errorMessage != null) const Placeholder(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: agents.length,
              itemBuilder: (_, index) {
                final agent = agents[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: AgentItem(
                    title: agent.name,
                    image: agent.image,
                    description: agent.desc,
                    symbol: agent.symbol,
                    owner: agent.creatorUsername,
                    isLoading: _isLoading,
                    isActive: activatedAgents.contains(agent.key),
                    toggleActivate: () => _toggleActivate(agent.key),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
