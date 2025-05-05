import 'package:kinship_bots/models/agent.dart';

class AgentsState {
  final List<Agent> agents;
  final Agent? selectedAgent;
  final Set<String> activatedAgents;
  final List<Agent> availableAgents;

  AgentsState({
    required this.agents,
    required this.selectedAgent,
    required this.activatedAgents,
    required this.availableAgents,
  });
}
