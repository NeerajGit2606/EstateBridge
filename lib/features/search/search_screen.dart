import 'package:flutter/material.dart';
import '../widgets/search_tabs.dart';
import '../widgets/search_input.dart';
import '../widgets/selected_chips.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  final List<String> _selectedLocations = [];
  bool _listVisible = false;
  bool _bottomChipsVisible = false;
  List<Map<String, dynamic>> _searchApiResults = [];

  final Map<String, List<Map<String, dynamic>>> _searchBarChips_bottomchips =
      {};

  Future<void> _fetchSearchResults(String query) async {
    if (query.trim().length < 3) {
      return;
    }

    try {
      final uri = Uri.parse('http://10.0.2.2:3000/search?q=$query');
      debugPrint('uri.$uri');

      final response = await http.get(uri);
      debugPrint('response.$response');
      if (response.statusCode != 200) {
        debugPrint('[SearchScreen] API failed');
        return;
      }

      final List<dynamic> data = jsonDecode(response.body);
      final List<Map<String, dynamic>> results = data
          .take(5)
          .cast<Map<String, dynamic>>()
          .toList();

      setState(() {
        _searchApiResults = results;
        _listVisible = true;
        _bottomChipsVisible = false;
      });
    } catch (e) {
      debugPrint('[SearchScreen] API error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> listResults = _searchApiResults.where((
      item,
    ) {
      return !_selectedLocations.contains(item['name']);
    }).toList();
    debugPrint(' 71 _listResults $listResults');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 56,
              color: Colors.indigo,

              child: Row(
                children: [
                  const Expanded(child: SearchTabs()),
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

            SearchInput(
              selectedLocations: _selectedLocations,
              onQueryChanged: (value) {
                debugPrint('[SearchScreen] Input received: $value');
                _fetchSearchResults(value);
              },
              onChipRemoved: (value) {
                debugPrint('[SearchScreen] Chip removed: $value');
                setState(() {
                  _selectedLocations.remove(value);
                  _searchBarChips_bottomchips.remove(value);
                  _listVisible = false;
                });
              },
            ),

            if (_listVisible)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),

                  itemCount: listResults.length,
                  itemBuilder: (context, index) {
                    final item = listResults[index];
                    return ListTile(
                      leading: const Icon(Icons.location_on_outlined, size: 20),
                      title: Text(
                        item['name'],
                        style: const TextStyle(fontSize: 14),
                      ),

                      subtitle: item['parent_city'] != null
                          ? Text(
                              item['parent_city'],
                              style: const TextStyle(fontSize: 11),
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          if (!_selectedLocations.contains(item['name'])) {
                            _selectedLocations.add(item['name']);

                            _searchBarChips_bottomchips.putIfAbsent(
                              item['name'],
                              () => [],
                            );

                            _searchBarChips_bottomchips[item['name']]!.addAll(
                              _searchApiResults.where(
                                (e) =>
                                    e['name'] != item['name'] &&
                                    !_searchBarChips_bottomchips[item['name']]!
                                        .any((c) => c['name'] == e['name']),
                              ),
                            );
                          }

                          debugPrint(
                            '[SearchScreen] _searchBarChips_bottomchips: $_searchBarChips_bottomchips',
                          );

                          _listVisible = false;
                          _bottomChipsVisible = true;
                        });
                      },
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),

            if (_bottomChipsVisible)
              SelectedChips(
                selectedLocations: _searchBarChips_bottomchips.values
                    .expand((list) => list)
                    .map((item) => item['name'] as String)
                    .toSet()
                    .toList(),

                onChanged: (updatedList) {
                  debugPrint('--- Bottom chip tapped ---');
                  debugPrint('Incoming updatedList: $updatedList');

                  setState(() {
                    // 🔹 Loop through each tapped bottom chip
                    for (final chipName in updatedList) {
                      debugPrint('Processing chipName: $chipName');

                      // 🔹 1. Add bottom chip into search bar chips if not already selected
                      if (!_selectedLocations.contains(chipName)) {
                        debugPrint('Adding "$chipName" to _selectedLocations');
                        _selectedLocations.add(chipName);
                      } else {
                        debugPrint(
                          '"$chipName" already exists in _selectedLocations',
                        );
                      }

                      // 🔹 2. Ensure key exists in map
                      if (!_searchBarChips_bottomchips.containsKey(chipName)) {
                        debugPrint('Creating new key in map for: $chipName');
                        _searchBarChips_bottomchips.putIfAbsent(
                          chipName,
                          () => [],
                        );
                      } else {
                        debugPrint('Key already exists in map for: $chipName');
                      }

                      // 🔹 3. Populate nearby values for this key
                      for (final e in _searchApiResults) {
                        debugPrint('Evaluating nearby candidate: ${e['name']}');

                        final alreadyExists =
                            _searchBarChips_bottomchips[chipName]!.any(
                              (c) => c['name'] == e['name'],
                            );

                        if (e['name'] == chipName) {
                          debugPrint('Skipping self reference: ${e['name']}');
                        } else if (alreadyExists) {
                          debugPrint(
                            'Already exists in value list: ${e['name']}',
                          );
                        } else {
                          debugPrint(
                            'Adding "${e['name']}" under key "$chipName"',
                          );
                          _searchBarChips_bottomchips[chipName]!.add(e);
                        }
                      }
                    }

                    // 🔹 4. Cleanup: remove selected locations from all value lists
                    debugPrint(
                      'Cleaning promoted chips from other value lists',
                    );

                    _searchBarChips_bottomchips.forEach((key, value) {
                      debugPrint('Checking key: $key');

                      value.removeWhere((e) {
                        final shouldRemove = _selectedLocations.contains(
                          e['name'],
                        );
                        if (shouldRemove) {
                          debugPrint(
                            'Removing "${e['name']}" from value list of key "$key"',
                          );
                        }
                        return shouldRemove;
                      });
                    });

                    // 🔹 Final state snapshot
                    debugPrint('FINAL _selectedLocations: $_selectedLocations');
                    debugPrint(
                      'FINAL _searchBarChips_bottomchips: $_searchBarChips_bottomchips',
                    );
                    debugPrint('--- Bottom chip processing completed ---');
                  });
                },
              ),

            // ✅ THIS IS THE KEY FIX
            // 🔹 EMPTY / LIST / CHIPS AREA TAKES ALL FREE SPACE
            Expanded(
              child: Container(), // later list / chips will come here
            ),

            // 🔹 BOTTOM BAR (ALWAYS AT BOTTOM)
            Container(
              height: 56,
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black12)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔹 Clear All (LEFT)
                  GestureDetector(
                    onTap: () {
                      debugPrint('[BottomBar] Clear All tapped');
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // 🔹 Next (RIGHT – auto aligned)
                  GestureDetector(
                    onTap: () {
                      debugPrint('[BottomBar] Add clicked');
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700, // solid blue
                        borderRadius: BorderRadius.circular(
                          6,
                        ), // matches screenshot
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
