import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/onboarding/welcome_screen.dart';
import '../dashboards/guest/guest_home.dart';
import '../shared/theme/app_theme.dart';

class EstateBridgeApp extends StatefulWidget {
  const EstateBridgeApp({super.key});

  @override
  State<EstateBridgeApp> createState() => _EstateBridgeAppState();
}

class _EstateBridgeAppState extends State<EstateBridgeApp> {
  late final Future<Widget> _startScreenFuture;

  @override
  void initState() {
    super.initState();
    _startScreenFuture = _resolveStartScreen();
  }

  /// Runs ONLY ONCE when app starts
  Future<Widget> _resolveStartScreen() async {
    final prefs = await SharedPreferences.getInstance();

    final hasSeenWelcome = prefs.getBool('has_seen_welcome') ?? false;
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    // 1️⃣ Logged-in users → main app
    if (isLoggedIn) {
      return const GuestHome(); // later UserHome
    }

    // 2️⃣ First-ever launch → Welcome
    if (!hasSeenWelcome) {
      // Mark immediately so next launch skips welcome
      await prefs.setBool('has_seen_welcome', true);
      return const WelcomeScreen();
    }

    // 3️⃣ Returning users without login → Guest mode
    return const GuestHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EstateBridge',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: FutureBuilder<Widget>(
        future: _startScreenFuture, // cached future
        builder: (context, snapshot) {
          // While async work is running → show loader
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // If something failed during startup resolution
          if (snapshot.hasError) {
            // Log error instead of crashing app
            debugPrint('Startup error: ${snapshot.error}');

            return const Scaffold(
              body: Center(
                child: Text(
                  'Something went wrong',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          // SUCCESS CASE
          // snapshot.data is guaranteed non-null here
          return snapshot.data!;
        },
      ),
    );
  }
}
