import 'package:flutter/material.dart';

/// ------------------------------------------------------------
/// WelcomeScreen
/// ------------------------------------------------------------
/// This is the FIRST screen of the application.
/// Similar to apps like 99acres / NoBroker, this screen:
/// 1. Builds trust (branding + value proposition)
/// 2. Allows soft entry via phone number
/// 3. Gives option to skip login ("Do it later")
///
/// NOTE:
/// - This screen does NOT authenticate the user.
/// - Authentication (OTP / Firebase Auth) will come later.
/// ------------------------------------------------------------
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Light background color for a clean, modern look
      backgroundColor: const Color(0xFFF5F7FB),

      /// SafeArea ensures UI does not overlap
      /// with notch, status bar, or system gestures
      body: SafeArea(
        child: Column(
          children: [
            // =========================================================
            // 1️⃣ TOP HERO SECTION (Branding + Trust)
            // =========================================================
            // This section visually introduces the app.
            // It takes less space than the bottom section
            // but enough to establish brand identity.
            Expanded(
              flex: 4, // 40% of the vertical screen
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    /// Placeholder icon for illustration / image
                    /// In production, this can be replaced with:
                    /// - Lottie animation
                    /// - SVG illustration
                    /// - Static image
                    Icon(
                      Icons.apartment_rounded,
                      size: 120,
                      color: Colors.indigo,
                    ),

                    SizedBox(height: 16),

                    /// App name / Brand name
                    /// This should be bold and clearly visible
                    Text(
                      'EstateBridge',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    /// Short value proposition
                    /// Explains WHAT the app does in one glance
                    Text(
                      'Buy, Sell & Rent properties\nwithout brokerage',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =========================================================
            // 2️⃣ BOTTOM ACTION SECTION (User Interaction)
            // =========================================================
            // This section behaves like a "bottom sheet".
            // It contains:
            // - Login / Register prompt
            // - Phone number input
            // - Primary and secondary actions
            Expanded(
              flex: 6, // 60% of the vertical screen
              child: Container(
                padding: const EdgeInsets.all(24),

                /// Rounded top corners give a modern,
                /// bottom-sheet style appearance
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Section title
                    /// This text sets user expectation
                    const Text(
                      'Login or Register to get started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // -----------------------------------------------------
                    // PHONE NUMBER INPUT FIELD
                    // -----------------------------------------------------
                    // This field collects user's mobile number.
                    // In later steps:
                    // - OTP will be sent
                    // - Firebase Phone Auth will be triggered
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        /// Country code prefix (India)
                        prefixText: '+91 ',
                        hintText: 'Enter phone number',

                        /// Rounded border for better UX
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // -----------------------------------------------------
                    // PRIMARY CTA BUTTON (CONTINUE)
                    // -----------------------------------------------------
                    // This is the main action on the screen.
                    // Visually strong to guide user forward.
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          /// TODO (Next Phase):
                          /// 1. Validate phone number
                          /// 2. Trigger OTP screen
                          /// 3. Start Firebase Phone Authentication
                        },

                        /// Styling to make it prominent
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // -----------------------------------------------------
                    // SECONDARY CTA (SKIP LOGIN)
                    // -----------------------------------------------------
                    // This allows users to explore the app
                    // without authentication.
                    //
                    // Business logic later:
                    // - Limited browsing
                    // - No contact details visible
                    // - Prompt login again on restricted actions
                    TextButton(
                      onPressed: () {
                        /// TODO:
                        /// Navigate to limited-access home screen
                      },
                      child: const Text('Do it later'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
