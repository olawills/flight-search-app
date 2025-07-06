import 'package:flutter/material.dart';

class AppConstants {
  static const String baseUrl = 'https://api.aviationstack.com/v1';
  static const String apiKey = 'YOUR_API_KEY';

  // For demo purposes, we'll use mock data
  static const bool useMockData = true;
}

class AppColors {
  static const Color primary = Color(0xFF1976D2);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB00020);

  // Gradient colors for walkthrough
  static const Color gradient1 = Color(0xFF667eea);
  static const Color gradient2 = Color(0xFFf093fb);
  static const Color gradient3 = Color(0xFF4facfe);
  static const Color gradient4 = Color(0xFF00f2fe);
}
