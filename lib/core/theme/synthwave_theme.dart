import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class SynthwaveTheme {
  SynthwaveTheme._();

  // === DARK THEME (PRIMARY) ===
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.neonPink,
      secondary: AppColors.electricPurple,
      tertiary: AppColors.cyan,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
      onPrimary: AppColors.textPrimary,
      onSecondary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onError: AppColors.textPrimary,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDarker,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.h4,
    ),
    cardTheme: CardTheme(
      color: AppColors.backgroundCard,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: AppColors.electricPurple,
          width: 0.5,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.neonPink,
        foregroundColor: AppColors.textPrimary,
        elevation: 8,
        shadowColor: AppColors.neonPink.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTextStyles.button,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.neonPink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(
          color: AppColors.neonPink,
          width: 1.5,
        ),
        textStyle: AppTextStyles.button,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.cyan,
        textStyle: AppTextStyles.label,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundCardLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.electricPurple),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.electricPurple, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.neonPink, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      labelStyle: AppTextStyles.bodyMedium,
      hintStyle: AppTextStyles.bodySmall,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.neonPink,
      foregroundColor: AppColors.textPrimary,
      elevation: 12,
      shape: CircleBorder(),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundDarker,
      selectedItemColor: AppColors.neonPink,
      unselectedItemColor: AppColors.textMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 16,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.backgroundDarker,
      indicatorColor: AppColors.neonPink.withOpacity(0.3),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTextStyles.label.copyWith(color: AppColors.neonPink);
        }
        return AppTextStyles.caption;
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.neonPink);
        }
        return const IconThemeData(color: AppColors.textMuted);
      }),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.electricPurpleDark,
      thickness: 0.5,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.backgroundCardLight,
      selectedColor: AppColors.neonPink,
      labelStyle: AppTextStyles.bodySmall,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.electricPurple),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.neonPink,
      linearTrackColor: AppColors.backgroundCardLight,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.neonPink,
      inactiveTrackColor: AppColors.backgroundCardLight,
      thumbColor: AppColors.neonPinkLight,
      overlayColor: AppColors.neonPink.withOpacity(0.2),
      valueIndicatorColor: AppColors.neonPink,
      valueIndicatorTextStyle: AppTextStyles.bodySmall,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.neonPink;
        }
        return AppColors.textMuted;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.neonPink.withOpacity(0.5);
        }
        return AppColors.backgroundCardLight;
      }),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.neonPink,
      unselectedLabelColor: AppColors.textMuted,
      indicatorColor: AppColors.neonPink,
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.backgroundCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.electricPurple),
      ),
      titleTextStyle: AppTextStyles.h4,
      contentTextStyle: AppTextStyles.bodyMedium,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.backgroundCard,
      contentTextStyle: AppTextStyles.bodyMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.electricPurple),
      ),
      textStyle: AppTextStyles.bodySmall,
    ),
  );

  // === LIGHT THEME (OPTIONAL) ===
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.neonPink,
      secondary: AppColors.electricPurple,
      tertiary: AppColors.cyan,
      surface: Color(0xFFF5F5FF),
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F8FF),
  );
}
