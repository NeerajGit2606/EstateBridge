import 'package:flutter/material.dart';

/// Tabs shown at top of search screen
/// Later this will control filters
class SearchTabs extends StatefulWidget {
  const SearchTabs({super.key});

  @override
  State<SearchTabs> createState() => _SearchTabsState();
}

class _SearchTabsState extends State<SearchTabs> {
  int _selectedIndex = 0;

  final tabs = const ['Buy', 'Rent/PG', 'Commercial'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabs.length, (index) {
        final isActive = index == _selectedIndex;

        return GestureDetector(
          onTap: () {
            debugPrint('[SearchTabs] Selected: ${tabs[index]}');

            setState(() {
              _selectedIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tabs[index],
              style: TextStyle(
                color: isActive ? Colors.indigo : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }),
    );
  }
}
