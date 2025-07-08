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

  static Color consistentBg = Colors.grey.withOpacity(0.1);
  static Color textPrimary = Color(0xFF0D141C);
  static Color decoratorColor = Color(0XFFE8EDF5);
  static Color decoratorText = Color(0XFF4A739C);
  static Color butonColor = Color(0xFF0D80F2);
  static Color cardColor = Color(0xFFE8EDF5);

  // Gradient colors for walkthrough
  static const Color gradient1 = Color(0xFF5eb2f6);
  static const Color gradient2 = Color(0xFF9a7ce8);
  static const Color gradient3 = Color(0xFF66b5f6);
  static const Color gradient4 = Color(0xFF7d5ee0);
  static const Color gradient5 = Color(0xFFff7b5a);
  static const Color gradient6 = Color(0xFFff9979);
}
