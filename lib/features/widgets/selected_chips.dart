import 'package:flutter/material.dart';

/// ----------------------------------------------
/// SelectedChips
/// ----------------------------------------------
/// Responsibility:
/// - Display selected cities / localities
/// - Allow ❌ removal
/// - No business logic, only UI + callbacks
class SelectedChips extends StatelessWidget {
  /// List of selected cities/localities
  final List<String> selectedLocations;

  /// Callback to notify parent after deletion
  final ValueChanged<List<String>> onChanged;

  const SelectedChips({
    super.key,
    required this.selectedLocations,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    /// If nothing selected → render nothing (important UX)
    if (selectedLocations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Wrap(
        spacing: 10,
        runSpacing: 10,

        /// Create one chip per selected location
        children: selectedLocations.map((city) {
          return ActionChip(
            avatar: const Icon(Icons.add, size: 16),
            label: Text(city),
            onPressed: () {
              debugPrint('[SelectedChips] Chip tapped: $city');
              onChanged([city]); // ✅ valid here
            },
          );
        }).toList(),
      ),
    );
  }
}
