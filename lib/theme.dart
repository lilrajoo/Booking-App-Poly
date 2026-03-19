import 'package:flutter/material.dart'; // Import the Flutter Material library

// Define the theme as a final variable of type ThemeData
final ThemeData theme = ThemeData(
  brightness: Brightness.dark, // Set the overall brightness to dark mode
  primaryColor: Colors.teal[700], // Set the primary color to a shade of teal
  hintColor: Colors.tealAccent, // Set the hint color to teal accent

  // Define the color scheme for the app
  colorScheme: ColorScheme.dark(
    primary: Colors.teal[700]!, // Set the primary color for the color scheme
    secondary:
        Colors.tealAccent, // Set the secondary color for the color scheme
    surface: Colors.grey[850]!, // Set the surface color for cards and surfaces
    background: Colors.grey[900]!, // Set the background color for the app
  ),

  scaffoldBackgroundColor:
      Colors.grey[900], // Set the background color for the scaffold

  // Define the theme for the app bar
  appBarTheme: AppBarTheme(
    backgroundColor:
        Colors.teal[700], // Set the background color of the app bar
    foregroundColor:
        Colors.white, // Set the foreground (text) color of the app bar
    elevation: 0, // Remove the elevation (shadow) of the app bar
  ),

  // Define the theme for elevated buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, // Set the text color for elevated buttons
      backgroundColor:
          Colors.teal[600], // Set the background color for elevated buttons
      padding: const EdgeInsets.symmetric(
          horizontal: 24, vertical: 12), // Set the padding for elevated buttons
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              8)), // Set the shape and border radius for elevated buttons
    ),
  ),

  // Define the theme for input decorations
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            8)), // Set the border style and radius for input fields
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
          8), // Set the border radius for focused input fields
      borderSide: const BorderSide(
          color: Colors.tealAccent,
          width: 2), // Set the border color and width for focused input fields
    ),
    filled: true, // Enable filling for input fields
    fillColor: Colors.grey[850], // Set the fill color for input fields
  ),
);
