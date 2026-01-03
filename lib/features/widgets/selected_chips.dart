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
          return InputChip(
            /// Display city/locality name
            label: Text(city),

            /// ❌ delete handler
            onDeleted: () {
              /// Debug log for tracing delete action
              debugPrint('[SelectedChips] Removed: $city');

              /// Create a new list to avoid mutating original reference
              final updatedList = List<String>.from(selectedLocations)
                ..remove(city);

              /// Notify parent (SearchScreen) to update state
              onChanged(updatedList);
            },
          );
        }).toList(),
      ),
    );
  }
}
