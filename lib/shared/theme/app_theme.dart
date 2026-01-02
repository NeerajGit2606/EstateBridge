// Imports Flutter’s Material Design package.
// ThemeData, ColorScheme, TextTheme, etc. come from here.
import 'package:flutter/material.dart';

/// AppTheme
/// --------
/// This class defines the global visual identity of the application.
///
/// Why central theme?
/// - Consistent UI across all screens
/// - Easy rebranding (change colors in one place)
/// - Future support for dark mode
/// - Cleaner widget code (less inline styling)
///
/// Real-world apps (99acres, NoBroker, Airbnb) always use a central theme.
class AppTheme {
  /// Private constructor to prevent instantiation.
  /// This class is intended to be used statically.
  AppTheme._();

  /// Light theme configuration for the application.
  ///
  /// This is the default theme used across the app.
  /// Later, a darkTheme can be added alongside this.
  static ThemeData get lightTheme {
    return ThemeData(
      // Enables Material Design 3 (latest design system by Google).
      // Provides better defaults for spacing, typography, and components.
      useMaterial3: true,

      // Defines the primary color palette of the app.
      // We use a professional blue tone suitable for real estate platforms.
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2563EB), // Blue (trust, reliability)
        brightness: Brightness.light,
      ),

      // Background color used by Scaffold widgets.
      // A very light grey is easier on the eyes than pure white.
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),

      // Default font family for the entire app.
      // Roboto is widely used, readable, and professional.
      fontFamily: 'Roboto',

      // Global AppBar styling.
      appBarTheme: const AppBarTheme(
        // Removes shadow for a cleaner, modern look.
        elevation: 0,

        // Background color of AppBar.
        backgroundColor: Colors.transparent,

        // Foreground color (icons, text).
        foregroundColor: Colors.black,
      ),

      // Global text styling.
      // These styles are used unless overridden locally.
      textTheme: const TextTheme(
        // Large titles (e.g., screen headings)
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),

        // Medium titles (section headings)
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),

        // Normal body text
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),

        // Small helper or caption text
        bodySmall: TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
      ),

      // Global styling for ElevatedButton.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // Button background color comes from the color scheme.
          backgroundColor: const Color(0xFF2563EB),

          // Text color inside buttons.
          foregroundColor: Colors.white,

          // Button shape.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),

          // Minimum height for buttons (touch-friendly).
          minimumSize: const Size.fromHeight(48),
        ),
      ),

      // Global styling for input fields (TextField, TextFormField).
      inputDecorationTheme: InputDecorationTheme(
        // Outline border for text fields.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),

        // Border when the field is focused.
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFF2563EB),
          ),
        ),
      ),
    );
  }
}
