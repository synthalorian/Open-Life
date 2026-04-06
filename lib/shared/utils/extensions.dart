import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Extension methods for common operations

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension NumExtensions on num {
  bool isBetween(num from, num to) {
    return from <= this && this <= to;
  }
}

extension DateTimeExtensions on DateTime {
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[month - 1]} $day, $year';
  }
}

/// Helper for generating gradient decorations
class GradientHelper {
  static BoxDecoration neonGlow({
    required Color color,
    double radius = 16,
    double glowRadius = 20,
  }) {
    return BoxDecoration(
      gradient: AppColors.sunsetGradient,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.5),
          blurRadius: glowRadius,
          spreadRadius: 2,
        ),
      ],
    );
  }

  static BoxDecoration chromeCard({
    double radius = 16,
  }) {
    return BoxDecoration(
      gradient: AppColors.chromeGradient,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        const BoxShadow(
          color: AppColors.chrome,
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    );
  }
}

/// Constants for grid pattern backgrounds
class GridPattern {
  static const double lineWidth = 0.5;
  static const double spacing = 20.0;
  static const Color lineColor = AppColors.electricPurpleDark;
}
