import 'package:bigagent/widgets/common/molecules/custom_search_field.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenDim = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: CustomSearchField(
        controller: _controller,
        executeSearch: () {},
        width: screenDim.width * 0.80,
        height: screenDim.height * 0.05,
      ),
    );
  }
}
