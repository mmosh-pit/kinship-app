import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AgentItem extends StatefulWidget {
  final String title;
  final String image;
  final String description;
  final String symbol;
  final String owner;
  final bool isActive;
  final bool isLoading;
  final VoidCallback toggleActivate;

  const AgentItem({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.symbol,
    required this.owner,
    required this.isActive,
    required this.isLoading,
    required this.toggleActivate,
  });

  @override
  State<AgentItem> createState() => _AgentItemState();
}

class _AgentItemState extends State<AgentItem> {
  bool _isOpen = false;

  void _toggleOpen() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF191754),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2B2897), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 5,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2, top: 2),
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    imageBuilder:
                        (context, imageProvider) => Container(
                          width: 60.0,
                          height: 60.0,
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
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: theme.textTheme.titleSmall,
                            ),
                            InkWell(
                              onTap: _toggleOpen,
                              child: Icon(
                                _isOpen
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "By ${widget.owner}",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: const Color(0xFFB5B5B5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.symbol,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                decoration: TextDecoration.underline,
                                color: const Color(0xFFB5B5B5),
                                decorationColor: const Color(0xFFB5B5B5),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: widget.toggleActivate,
                              style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    // side: BorderSide(co)
                                  ),
                                ),
                                backgroundColor: WidgetStatePropertyAll(
                                  widget.isActive
                                      ? const Color(0xFF09073A)
                                      : const Color(0xFFFF00AE),
                                ),
                                padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 20,
                                  ),
                                ),
                              ),
                              child:
                                  widget.isLoading
                                      ? const CircularProgressIndicator()
                                      : Text(
                                        widget.isActive
                                            ? "Deactivate"
                                            : "Activate",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_isOpen)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                child: Text(
                  widget.description,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFFB5B5B5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
