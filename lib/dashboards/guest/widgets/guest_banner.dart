import 'package:flutter/material.dart';

/// Top banner shown on Guest Home
/// Similar to promotional banners on 99acres / NoBroker
class GuestBanner extends StatelessWidget {
  const GuestBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),

      /// Rounded card-like container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/banner.jpg'), // placeholder
          fit: BoxFit.cover,
        ),
      ),

      /// Overlay for text readability
      height: 180,
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(16),
      child: const Text(
        'Find your perfect home',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
