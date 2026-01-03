import 'package:flutter/material.dart';

/// Bottom navigation for Guest users
/// Will later be reused for logged-in users
class GuestBottomNav extends StatelessWidget {
  const GuestBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {
        debugPrint('[GuestBottomNav] tapped index $index');

        // Future:
        // index != 0 → prompt login
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Shortlisted',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
