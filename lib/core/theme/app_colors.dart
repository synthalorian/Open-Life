import 'package:flutter/material.dart';

/// Synthwave color palette for Open Life
/// Inspired by 80s neon, sunset gradients, and chrome aesthetics
class AppColors {
  AppColors._();

  // === PRIMARY NEON COLORS ===
  static const Color neonPink = Color(0xFFFF0080);
  static const Color neonPinkLight = Color(0xFFFF66B2);
  static const Color neonPinkDark = Color(0xFFCC0066);
  
  static const Color electricPurple = Color(0xFF8B00FF);
  static const Color electricPurpleLight = Color(0xFFB366FF);
  static const Color electricPurpleDark = Color(0xFF6600CC);
  
  static const Color cyan = Color(0xFF00FFFF);
  static const Color cyanLight = Color(0xFF66FFFF);
  static const Color cyanDark = Color(0xFF00CCCC);

  // === SUNSET GRADIENT COLORS ===
  static const Color sunsetOrange = Color(0xFFFF6B35);
  static const Color sunsetYellow = Color(0xFFFFD700);
  static const Color sunsetPink = Color(0xFFFF1493);
  static const Color deepPurple = Color(0xFF4A0080);

  // === BACKGROUND COLORS ===
  static const Color backgroundDark = Color(0xFF0A0A1A);
  static const Color backgroundDarker = Color(0xFF050510);
  static const Color backgroundCard = Color(0xFF1A1A2E);
  static const Color backgroundCardLight = Color(0xFF252540);
  static const Color surfaceDark = Color(0xFF16162A);

  // === CHROME/METALLIC ===
  static const Color chrome = Color(0xFFC0C0C0);
  static const Color chromeLight = Color(0xFFE8E8E8);
  static const Color chromeDark = Color(0xFF808080);
  static const Color gold = Color(0xFFFFD700);

  // === TEXT COLORS ===
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB8B8D0);
  static const Color textMuted = Color(0xFF6A6A8A);

  // === STATUS COLORS ===
  static const Color success = Color(0xFF00FF88);
  static const Color successDark = Color(0xFF00CC6A);
  static const Color warning = Color(0xFFFFB800);
  static const Color warningDark = Color(0xFFCC9300);
  static const Color error = Color(0xFFFF3366);
  static const Color errorDark = Color(0xFFCC2952);
  static const Color info = Color(0xFF00B8FF);

  // === FEATURE-SPECIFIC COLORS ===
  // Fitness
  static const Color fitnessPrimary = Color(0xFF00FF88);
  static const Color fitnessSecondary = Color(0xFF00CC6A);
  
  // Finance
  static const Color financePrimary = Color(0xFFFFD700);
  static const Color financeSecondary = Color(0xFFFFB800);
  
  // Assurance
  static const Color assurancePrimary = Color(0xFF00B8FF);
  static const Color assuranceSecondary = Color(0xFF0095CC);

  // === GRADIENTS ===
  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      sunsetPink,
      neonPink,
      electricPurple,
      deepPurple,
    ],
  );

  static const LinearGradient neonGlowGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      neonPink,
      electricPurple,
      cyan,
    ],
  );

  static const LinearGradient chromeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      chromeLight,
      chrome,
      chromeDark,
      chrome,
      chromeLight,
    ],
  );

  static const LinearGradient fitnessGradient = LinearGradient(
    colors: [fitnessPrimary, fitnessSecondary],
  );

  static const LinearGradient financeGradient = LinearGradient(
    colors: [financePrimary, financeSecondary],
  );

  static const LinearGradient assuranceGradient = LinearGradient(
    colors: [assurancePrimary, assuranceSecondary],
  );

  // === GLOW EFFECTS ===
  static const List<BoxShadow> neonPinkGlow = [
    BoxShadow(
      color: Color(0x80FF0080),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static const List<BoxShadow> neonPurpleGlow = [
    BoxShadow(
      color: Color(0x808B00FF),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static const List<BoxShadow> cyanGlow = [
    BoxShadow(
      color: Color(0x8000FFFF),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static const List<BoxShadow> successGlow = [
    BoxShadow(
      color: Color(0x8000FF88),
      blurRadius: 15,
      spreadRadius: 1,
    ),
  ];
}
