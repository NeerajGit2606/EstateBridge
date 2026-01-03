import 'package:flutter/material.dart';
import '../../../features/search/search_screen.dart';

/// Read-only search bar for Guest users
/// No action allowed without login
class GuestSearchBar extends StatelessWidget {
  const GuestSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          debugPrint('[GuestSearch] Opening search screen');

          // Navigate to full search experience
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchScreen()),
          );
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search "Noida", "Flats", "Rent"',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
