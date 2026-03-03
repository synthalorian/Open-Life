import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // === HEADINGS ===
  static TextStyle get h1 => GoogleFonts.rajdhani(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 2,
  );

  static TextStyle get h2 => GoogleFonts.rajdhani(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 1.5,
  );

  static TextStyle get h3 => GoogleFonts.rajdhani(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 1,
  );

  static TextStyle get h4 => GoogleFonts.rajdhani(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle get h5 => GoogleFonts.rajdhani(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // === BODY TEXT ===
  static TextStyle get bodyLarge => GoogleFonts.rajdhani(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyMedium => GoogleFonts.rajdhani(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get bodySmall => GoogleFonts.rajdhani(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  // === SPECIAL STYLES ===
  static TextStyle get neonTitle => GoogleFonts.rajdhani(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.neonPink,
    letterSpacing: 3,
    shadows: [
      const Shadow(
        color: AppColors.neonPink,
        blurRadius: 20,
      ),
      const Shadow(
        color: AppColors.electricPurple,
        blurRadius: 40,
      ),
    ],
  );

  static TextStyle get chromeText => GoogleFonts.rajdhani(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    foreground: Paint()
      ..shader = AppColors.chromeGradient.createShader(
        const Rect.fromLTWH(0, 0, 200, 50),
      ),
  );

  static TextStyle get gradientTitle => GoogleFonts.rajdhani(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    foreground: Paint()
      ..shader = AppColors.sunsetGradient.createShader(
        const Rect.fromLTWH(0, 0, 300, 50),
      ),
  );

  static TextStyle get caption => GoogleFonts.rajdhani(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    letterSpacing: 0.5,
  );

  static TextStyle get label => GoogleFonts.rajdhani(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 1,
  );

  static TextStyle get button => GoogleFonts.rajdhani(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 1.5,
  );

  // === NUMBERS & STATS ===
  static TextStyle get statLarge => GoogleFonts.rajdhani(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    color: AppColors.neonPink,
    shadows: const [
      Shadow(
        color: AppColors.neonPink,
        blurRadius: 15,
      ),
    ],
  );

  static TextStyle get statMedium => GoogleFonts.rajdhani(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get statSmall => GoogleFonts.rajdhani(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}
