import 'package:flutter/material.dart';
import 'widgets/guest_banner.dart';
import 'widgets/guest_search_bar.dart';
// import 'widgets/guest_quick_actions.dart';
// import 'widgets/guest_insights.dart';
import 'widgets/guest_bottom_nav.dart';

/// ------------------------------------------------------------
/// GuestHome
/// ------------------------------------------------------------
/// This screen is shown to users who
/// are not logged in.
/// ------------------------------------------------------------
class GuestHome extends StatelessWidget {
  const GuestHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EstateBridge'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Navigate to Login / OTP screen
            },
            child: const Text('Login'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        children: const [
          /// Top promotional / branding banner
          GuestBanner(),

          /// Property search UI (read-only for guest)
          GuestSearchBar(),

          /// Buy / Rent / Insights shortcuts
          //  GuestQuickActions(),

          /// Market insights cards
          //  GuestInsights(),
        ],
      ),
      bottomNavigationBar: const GuestBottomNav(),
    );
  }
}
