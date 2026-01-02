import 'package:flutter/material.dart';

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
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Browsing as Guest',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
