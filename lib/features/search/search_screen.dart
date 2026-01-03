import 'package:flutter/material.dart';
import '../widgets/search_tabs.dart';
import '../widgets/search_input.dart';
import '../widgets/popular_cities.dart';
import '../widgets/selected_chips.dart';

/// ------------------------------------------------------------
/// SearchScreen
/// ------------------------------------------------------------
/// This screen replicates 99acres-style search:
/// - Accessible in Guest mode
/// - Full screen modal-style page
/// - No data fetch yet (UI + state only)
/// ------------------------------------------------------------
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Stores selected cities / localities (e.g., ["Noida"])
  final List<String> _selectedLocations = [];

  // Stores localities for currently selected city
  List<String> _nearbyLocalities = [];

  Map<String, List<String>> cityLocalities = {
    'Noida': ['Sector 62', 'Sector 18', 'Sector 137'],
    'Delhi': ['Dwarka', 'Rohini', 'Saket'],
  };

  // Helper getter to control bottom bar visibility
  bool get _showBottomBar => _selectedLocations.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// Top safe area to avoid notch overlap
      body: SafeArea(
        child: Column(
          children: [
            // --------------------------------------------------
            // HEADER (Tabs + Close button)
            // --------------------------------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 56,
              color: Colors.indigo,

              child: Row(
                children: [
                  /// Buy / Rent / Commercial tabs
                  const Expanded(child: SearchTabs()),

                  /// Close icon (dismiss search)
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      debugPrint('[SearchScreen] Closed');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Search input field
            SearchInput(
              selectedLocations: _selectedLocations,
              onLocationSubmitted: (value) {
                debugPrint('[SearchScreen] Submitted from input: $value');
                if (_selectedLocations.contains(value)) return;
                setState(() {
                  _selectedLocations.add(value);
                });
              },
            ),

            const SizedBox(height: 20),
            SelectedChips(
              selectedLocations: _selectedLocations,
              onChanged: (updatedList) {
                debugPrint('[SearchScreen] Chips updated: $updatedList');

                setState(() {
                  _selectedLocations
                    ..clear()
                    ..addAll(updatedList);
                });
              },
            ),

            /// City suggestions
            PopularCities(
              // 🔹 Called when user taps a city chip
              onCitySelected: (city) {
                debugPrint('[SearchScreen] Adding city to search: $city');

                // Prevent duplicate entries
                if (_selectedLocations.contains(city)) return;

                setState(() {
                  // Add selected city
                  _selectedLocations.add(city);

                  // Load localities for selected city
                  _nearbyLocalities = cityLocalities[city] ?? [];
                });

                // Debug log
                debugPrint(
                  '[SearchScreen] Loaded localities for $city: $_nearbyLocalities',
                );
              },
            ),
            // 🔹 Show nearby localities if available
            if (_nearbyLocalities.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,

                  children: _nearbyLocalities.map((locality) {
                    return InputChip(
                      // Display locality name
                      label: Text(locality),

                      // Handle locality selection
                      onPressed: () {
                        debugPrint(
                          '[SearchScreen] Locality selected: $locality',
                        );

                        // Prevent duplicates
                        if (_selectedLocations.contains(locality)) return;

                        setState(() {
                          _selectedLocations.add(locality);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
