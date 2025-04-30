import 'dart:async';

import 'package:bigagent/constants/error_messages.dart';
import 'package:bigagent/models/agent.dart';
import 'package:bigagent/models/agents_state.dart';
import 'package:bigagent/provider/solana_provider.dart';
import 'package:bigagent/services/agents_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgentsProvider extends AsyncNotifier<AgentsState> {
  Future<AgentsState> _getAgents() async {
    final agents = await AgentsService.getAgents();

    final activeAgents = await AgentsService.getActiveAgents();

    return AgentsState(
      agents: agents,
      selectedAgent: null,
      activatedAgents: activeAgents,
      availableAgents: [],
    );
  }

  @override
  FutureOr<AgentsState> build() {
    return _getAgents();
  }

  Future<String> toggleActivatedAgent(String agentId) async {
    final response = await AgentsService.activateAgent(agentId);

    if (response.isNotEmpty) {
      return errorMessages[response] ??
          "Something went wrong, please try again later or contact support.";
    }

    final data = state.value!;

    if (data.activatedAgents.contains(agentId)) {
      data.activatedAgents.remove(agentId);
    } else {
      data.activatedAgents.add(agentId);
    }

    state = AsyncValue.data(
      AgentsState(
        agents: data.agents,
        selectedAgent: data.selectedAgent,
        activatedAgents: data.activatedAgents,
        availableAgents: [],
      ),
    );

    setupAvailableAgents();

    return "";
  }

  void setupAvailableAgents() {
    final value = ref.read(asyncSolanaProvider).value;

    if (value == null) return;

    if (state.value == null) return;

    if (state.value!.activatedAgents.isEmpty) return;

    Set<String> availableNamespaces = {};

    for (final pass in value.passes) {
      if (pass.parentKey != null) {
        availableNamespaces.add(pass.parentKey!);
      }
    }

    List<Agent> availableAgents = [];

    for (final val in state.value!.activatedAgents) {
      if (availableNamespaces.contains(val)) {
        availableAgents.add(
          state.value!.agents.firstWhere((e) => e.key == val),
        );
      }
    }

    state = AsyncValue.data(
      AgentsState(
        agents: state.value!.agents,
        selectedAgent: null,
        activatedAgents: state.value!.activatedAgents,
        availableAgents: availableAgents,
      ),
    );
  }
}

final asyncAgentProvider = AsyncNotifierProvider<AgentsProvider, AgentsState>(
  () => AgentsProvider(),
);
