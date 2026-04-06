import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/neon_card.dart';
import '../../../../core/services/data_aggregator.dart';

/// AI-powered insight banner that shows cross-pillar insights
class AIInsightBanner extends ConsumerWidget {
  const AIInsightBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightsAsync = ref.watch(crossPillarInsightsProvider);

    return insightsAsync.when(
      data: (insights) {
        if (insights.isEmpty) return const SizedBox.shrink();

        final topInsight = insights.first;
        return _buildInsightBanner(topInsight);
      },
      loading: () => _buildLoadingBanner(),
      error: (err, stack) => const SizedBox.shrink(),
    );
  }

  Widget _buildInsightBanner(CrossPillarInsight insight) {
    final color = _getSeverityColor(insight.severity);
    
    return NeonCard(
      gradient: LinearGradient(
        colors: [
          color.withOpacity(0.2),
          AppColors.electricPurple.withOpacity(0.2),
        ],
      ),
      glowColor: color,
      onTap: insight.actionable ? () {} : null,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppColors.neonGlowGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(PhosphorIcons.sparkle(), color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        insight.title,
                        style: AppTextStyles.h5.copyWith(color: color),
                      ),
                    ),
                    ...insight.pillars.map((p) => Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        _getPillarIcon(p),
                        color: color.withOpacity(0.5),
                        size: 14,
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 4),
                Text(insight.description, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          if (insight.actionable && insight.action != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withOpacity(0.5)),
              ),
              child: Text(
                insight.action!,
                style: AppTextStyles.caption.copyWith(color: color),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingBanner() {
    return NeonCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.electricPurple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.electricPurple),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Analyzing your life data...',
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(InsightSeverity severity) {
    switch (severity) {
      case InsightSeverity.positive:
        return AppColors.success;
      case InsightSeverity.suggestion:
        return AppColors.cyan;
      case InsightSeverity.warning:
        return AppColors.warning;
      case InsightSeverity.critical:
        return AppColors.error;
    }
  }

  IconData _getPillarIcon(InsightPillar pillar) {
    switch (pillar) {
      case InsightPillar.fitness:
        return PhosphorIcons.barbell();
      case InsightPillar.finance:
        return PhosphorIcons.wallet();
      case InsightPillar.health:
        return PhosphorIcons.heart();
    }
  }
}

/// Mini AI insight widget for embedding in cards
class MiniAIInsight extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  MiniAIInsight({
    super.key,
    required this.text,
    IconData? icon,
    this.color = AppColors.cyan,
  }) : icon = icon ?? PhosphorIcons.sparkle();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.caption.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
