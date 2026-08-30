import 'package:flutter/material.dart';

/// Blackshield color palette — blood, steel, and bone. Gothic-warrior.
class BlackshieldColors {
  BlackshieldColors._();

  static const Color blood = Color(0xFFC1121F);
  static const Color bone = Color(0xFFD8D3C8);
  static const Color boneBright = Color(0xFFF5F1E8);
  static const Color voidBlack = Color(0xFF0D0D11);
  static const Color iron = Color(0xFF101014);
  static const Color steel = Color(0xFF16161C);
  static const Color steelLight = Color(0xFF1A1A20);
  static const Color ash = Color(0xFF8A8F98);
  static const Color steelBlue = Color(0xFF5B7FA6);
  static const Color steelBlueBright = Color(0xFF7B9DC4);
  static const Color warGold = Color(0xFFC9A227);
  static const Color fieldGreen = Color(0xFF6A994E);
  static const Color royalPurple = Color(0xFFA4508B);
}

/// Blackshield theme data
class BlackshieldTheme {
  BlackshieldTheme._();

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: BlackshieldColors.blood,
      secondary: BlackshieldColors.steelBlue,
      tertiary: BlackshieldColors.royalPurple,
      surface: BlackshieldColors.steel,
      error: BlackshieldColors.blood,
      onPrimary: BlackshieldColors.boneBright,
      onSecondary: BlackshieldColors.boneBright,
      onSurface: BlackshieldColors.bone,
      onError: BlackshieldColors.boneBright,
    ),
    scaffoldBackgroundColor: BlackshieldColors.iron,
    canvasColor: BlackshieldColors.voidBlack,
    appBarTheme: const AppBarTheme(
      backgroundColor: BlackshieldColors.iron,
      foregroundColor: BlackshieldColors.bone,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: BlackshieldColors.steel,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: BlackshieldColors.steelLight,
          width: 0.5,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: BlackshieldColors.blood,
        foregroundColor: BlackshieldColors.boneBright,
        elevation: 8,
        shadowColor: BlackshieldColors.blood.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: BlackshieldColors.blood,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(
          color: BlackshieldColors.blood,
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: BlackshieldColors.steelBlueBright,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: BlackshieldColors.steelLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: BlackshieldColors.steelLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: BlackshieldColors.steelLight, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: BlackshieldColors.blood, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: BlackshieldColors.blood),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: BlackshieldColors.blood,
      foregroundColor: BlackshieldColors.boneBright,
      elevation: 12,
      shape: CircleBorder(),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: BlackshieldColors.iron,
      selectedItemColor: BlackshieldColors.blood,
      unselectedItemColor: BlackshieldColors.ash,
      type: BottomNavigationBarType.fixed,
      elevation: 16,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: BlackshieldColors.iron,
      indicatorColor: BlackshieldColors.blood.withValues(alpha: 0.3),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: BlackshieldColors.blood);
        }
        return const IconThemeData(color: BlackshieldColors.ash);
      }),
    ),
    dividerTheme: const DividerThemeData(
      color: BlackshieldColors.steelLight,
      thickness: 0.5,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: BlackshieldColors.steelLight,
      selectedColor: BlackshieldColors.blood,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: BlackshieldColors.steelLight),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: BlackshieldColors.blood,
      linearTrackColor: BlackshieldColors.steelLight,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: BlackshieldColors.blood,
      inactiveTrackColor: BlackshieldColors.steelLight,
      thumbColor: BlackshieldColors.bone,
      overlayColor: BlackshieldColors.blood.withValues(alpha: 0.2),
      valueIndicatorColor: BlackshieldColors.blood,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BlackshieldColors.blood;
        }
        return BlackshieldColors.ash;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BlackshieldColors.blood.withValues(alpha: 0.5);
        }
        return BlackshieldColors.steelLight;
      }),
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: BlackshieldColors.blood,
      unselectedLabelColor: BlackshieldColors.ash,
      indicatorColor: BlackshieldColors.blood,
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: BlackshieldColors.steel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: BlackshieldColors.steelLight),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: BlackshieldColors.steel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: BlackshieldColors.steel,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BlackshieldColors.steelLight),
      ),
    ),
  );
}
