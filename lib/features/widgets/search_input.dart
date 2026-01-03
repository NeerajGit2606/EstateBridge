import 'package:flutter/material.dart';

/// Search input field
/// No API call yet – only UI
class SearchInput extends StatelessWidget {
  final List<String> selectedLocations;
  final ValueChanged<String> onLocationSubmitted;

  const SearchInput({
    super.key,
    required this.selectedLocations,
    required this.onLocationSubmitted, // 🔹 NEW
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: TextField(
        autofocus: true, // Focus immediately like 99acres
        decoration: InputDecoration(
          hintText: 'Try "Noida"',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: (value) {
          debugPrint('[SearchInput] typing: $value');
          debugPrint('[SearchInput] current selections: $selectedLocations');
        },
        // 🔹 Called when user presses DONE / ENTER on keyboard
        onSubmitted: (value) {
          // Trim input to avoid empty or space-only entries
          final text = value.trim();

          if (text.isEmpty) return;

          debugPrint('[SearchInput] submitted: $text');

          // 🔹 Notify SearchScreen to add location
          onLocationSubmitted(text);
        },
      ),
    );
  }
}
