import 'package:flutter/material.dart';

class ChatbotHeader extends StatefulWidget {
  const ChatbotHeader({super.key});

  @override
  State<ChatbotHeader> createState() => _ChatbotHeaderState();
}

const agents = [
  {"label": "Agent 1", "id": "1"},
  {"label": "Agent 2", "id": "2"},
  {"label": "Agent 3", "id": "3"}
];

class _ChatbotHeaderState extends State<ChatbotHeader> {
  bool _isDropdownOpen = false;

  final Set<String> _selectedAgents = {};

  final _layerLink = LayerLink();
  final _controller = OverlayPortalController();

  void _toggleDropdown() {
    _controller.toggle();
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenDim = MediaQuery.sizeOf(context);
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF030234),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 25,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        child: OverlayPortal(
          controller: _controller,
          overlayChildBuilder: (_) => Positioned(
            width: screenDim.width * 0.40,
            height: agents.length * 56,
            child: CompositedTransformFollower(
              link: _layerLink,
              followerAnchor: Alignment.topCenter,
              targetAnchor: const Alignment(-0.4, 0.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF1B1954),
                  border: Border.all(color: Colors.white10),
                ),
                padding: const EdgeInsets.all(5),
                child: Column(
                    spacing: 5,
                    children: agents
                        .map(
                          (agent) => Row(
                            children: [
                              Checkbox(
                                fillColor: const WidgetStatePropertyAll(
                                  Color(0xFF3D3999),
                                ),
                                side: BorderSide.none,
                                value: _selectedAgents.contains(agent["id"]),
                                onChanged: (value) {
                                  if (value!) {
                                    _selectedAgents.add(agent["id"]!);
                                  } else {
                                    _selectedAgents.remove(agent["id"]);
                                  }
                                  setState(() {});
                                },
                              ),
                              Text(
                                agent["label"] ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ),
            ),
          ),
          child: GestureDetector(
            onTap: _toggleDropdown,
            child: Row(
              children: [
                Text(
                  "Active Agents",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Icon(
                  _isDropdownOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
