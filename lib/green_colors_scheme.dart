import 'package:flutter/material.dart';

// Light Mode Colors (Greenish)
Color lBackgroundColor = const Color(0xFFE8F5E9); // Light green background
Color lFontColor = const Color(0xFF388E3C); // Dark green text color for light mode
Color lSecondaryFontColor = const Color(0xFF81C784); // Light green secondary text color
Color lButtonColor = const Color(0xFF4CAF50); // Green button color
Color lButtonTextColor = const Color(0xFFFFFFFF); // White text for buttons
Color lCardColor = const Color(0xFF61E763); // White card background
Color lShadowColor = const Color(0xFFBDBDBD); // Subtle gray shadow for light mode
Color lAccentColor = const Color(0xFF66BB6A); // Light green accent color
Color lIconColor = const Color(0xFF000000);

// Dark Mode Colors (Greenish)
Color dBackgroundColor = const Color(0xFF1B5E20); // Dark green background
Color dFontColor = const Color(0xFFFFFFFF); // White text color for dark mode
Color dSecondaryFontColor = const Color(0xFF81C784); // Lighter green text for dark mode
Color dButtonColor = const Color(0xFF66BB6A); // Lighter green button color
Color dButtonTextColor = const Color(0xFF000000); // Dark text for buttons in dark mode
Color dCardColor = const Color(0xFF2C6B2F); // Darker green card background
Color dShadowColor = const Color(0xFF388E3C); // Dark green shadow color
Color dAccentColor = const Color(0xFF83CC81); // Soft green accent color
Color dIconColor = const Color(0xFFFFFFFF);

// Example variables with conditional values for light/dark mode adaptivity
Color getBackgroundColor(bool isDarkMode) => isDarkMode ? dBackgroundColor : lBackgroundColor;
Color getFontColor(bool isDarkMode) => isDarkMode ? dFontColor : lFontColor;
Color getSecondaryFontColor(bool isDarkMode) => isDarkMode ? dSecondaryFontColor : lSecondaryFontColor;
Color getButtonColor(bool isDarkMode) => isDarkMode ? dButtonColor : lButtonColor;
Color getButtonTextColor(bool isDarkMode) => isDarkMode ? dButtonTextColor : lButtonTextColor;
Color getCardColor(bool isDarkMode) => isDarkMode ? dCardColor : lCardColor;
Color getShadowColor(bool isDarkMode) => isDarkMode ? dShadowColor : lShadowColor;
Color getAccentColor(bool isDarkMode) => isDarkMode ? dAccentColor : lAccentColor;
Color getIconColor(bool isDarkMode) => isDarkMode ? dIconColor : lIconColor;