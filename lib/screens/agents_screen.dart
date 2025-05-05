import 'package:kinship_bots/widgets/agents/organisms/agents_list.dart';
import 'package:kinship_bots/widgets/common/molecules/custom_search_field.dart';
import 'package:flutter/material.dart';

class AgentsScreen extends StatelessWidget {
  const AgentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenDim = MediaQuery.sizeOf(context);

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 40,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomSearchField(
                controller: TextEditingController(),
                executeSearch: () {},
                width: screenDim.width * 0.80,
                height: screenDim.height * 0.05,
              ),
            ),
            const AgentsList(),
          ],
        ),
      ),
    );
  }
}
