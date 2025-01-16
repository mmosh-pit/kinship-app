import 'package:bigagent/widgets/agents/molecules/agent_item.dart';
import 'package:flutter/material.dart';

const agents = [
  {
    "title": "Test Agent",
    "image":
        "https://storage.googleapis.com/mmosh-assets/profile_placeholder.png",
    "description":
        "A short and athletically built, golden-brown skinned man with piercing, brown eyes, small ears and large lips. He has coiled, black hair, has a small burn on his right thigh, has a tufty moustache, and he has a bulky torso with chiseled abs, average-sized feet, and weak legs. He is holding a large object.",
    "symbol": "SYMBOL",
    "owner": "Me",
  },
  {
    "title": "Test Agent 2",
    "image":
        "https://storage.googleapis.com/mmosh-assets/profile_placeholder.png",
    "description":
        "A petite, caramel skinned woman with candid, hazel eyes, thin eyebrows, an aquiline nose, full lips and a square jaw. She has coiled, salt and pepper hair, has a distinctive burn on her left thigh, has pierced both earlobes, and she seems goofy.",
    "symbol": "SYMBOL",
    "owner": "Me",
  },
  {
    "title": "Test Agent 3",
    "image":
        "https://storage.googleapis.com/mmosh-assets/profile_placeholder.png",
    "description":
        "A tall and wide, pine skinned woman with neutral, brown eyes, smooth cheeks, a rounded jaw and a large nose. She has straight, brown hair dyed red on one side and orange on the other, wears clothes that are slightly too big, seems rebellious, has numerous piercings, and she has nice cologne.",
    "symbol": "SYMBOL",
    "owner": "Me",
  },
  {
    "title": "Test Agent 4",
    "image":
        "https://storage.googleapis.com/mmosh-assets/profile_placeholder.png",
    "description":
        "A 6' 4\" tall, dark skinned person with intense, blue eyes, small ears and a small nose. They are bald, have a medium-length, tufty moustache",
    "symbol": "SYMBOL",
    "owner": "Me",
  },
  {
    "title": "Test Agent",
    "image":
        "https://storage.googleapis.com/mmosh-assets/profile_placeholder.png",
    "description":
        "A tall and solidly-built, olive skinned woman with patient, hazel eyes, small ears and a flat nose. She is bald, usually wears a certain style of trench coat",
    "symbol": "SYMBOL",
    "owner": "Me",
  },
];

class AgentsList extends StatelessWidget {
  const AgentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: agents.length,
        itemBuilder: (_, index) {
          final agent = agents[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: AgentItem(
              title: agent["title"]!,
              image: agent["image"]!,
              description: agent["description"]!,
              symbol: agent["symbol"]!,
              owner: agent["owner"]!,
            ),
          );
        },
      ),
    );
  }
}
