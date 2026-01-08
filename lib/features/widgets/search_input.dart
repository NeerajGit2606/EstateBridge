import 'package:flutter/material.dart';

/// Search input field
/// Stateful because we control TextEditingController
class SearchInput extends StatefulWidget {
  final List<String> selectedLocations;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String> onChipRemoved;

  const SearchInput({
    super.key,
    required this.selectedLocations,
    required this.onQueryChanged,
    required this.onChipRemoved,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  // 🔹 Controller to control and clear typed text
  final TextEditingController _controller = TextEditingController();

  @override
  void didUpdateWidget(covariant SearchInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 🔹 If a new chip was added, clear typed text
    if (widget.selectedLocations.isNotEmpty && _controller.text.isNotEmpty) {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _controller, // 🔹 attach controller
        autofocus: true,
        minLines: 1,
        maxLines: null,
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            minHeight: 0,
            minWidth: 0,
          ),
          prefixIcon: widget.selectedLocations.isNotEmpty
              ? Wrap(
                  spacing: 6,
                  children: widget.selectedLocations.map((location) {
                    return InputChip(
                      label: Text(
                        location,
                        style: const TextStyle(fontSize: 12),
                      ),
                      onDeleted: () {
                        debugPrint('[SearchInput] Chip removed: $location');
                        widget.onChipRemoved(location);
                      },
                    );
                  }).toList(),
                )
              : null,
          hintText:
              (widget.selectedLocations.isEmpty && _controller.text.isEmpty)
              ? 'Try "Noida"'
              : "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: (value) {
          debugPrint('[SearchInput] typing: $value');
          widget.onQueryChanged(value);
        },
      ),
    );
  }
}
