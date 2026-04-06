import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/neon_card.dart';
import '../providers/dashboard_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome message
                  ShaderMask(
                    shaderCallback: (bounds) => AppColors.sunsetGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Text(
                      'Welcome back',
                      style: AppTextStyles.h1.copyWith(color: Colors.white),
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                  const SizedBox(height: 8),
                  Text(
                    'Your life at a glance',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  
                  // AI Insight Banner
                  const SizedBox(height: 24),
                  _buildAIInsightBanner(context, ref),
                ],
              ),
            ),
          ),

          // Quick Stats
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Stats',
                    style: AppTextStyles.h4,
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: NeonStatCard(
                          title: 'Steps Today',
                          value: dashboardState.stepsToday.toString(),
                          subtitle: 'Goal: 10,000',
                          icon: PhosphorIcons.footprints(),
                          color: AppColors.fitnessPrimary,
                          onTap: () => context.go('/fitness'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: NeonStatCard(
                          title: 'Budget Left',
                          value: '\$${dashboardState.budgetRemaining}',
                          subtitle: 'This month',
                          icon: PhosphorIcons.wallet(),
                          color: AppColors.financePrimary,
                          onTap: () => context.go('/finance'),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: NeonStatCard(
                          title: 'Calories',
                          value: dashboardState.caloriesToday.toString(),
                          subtitle: 'Remaining: ${dashboardState.caloriesRemaining}',
                          icon: PhosphorIcons.fire(),
                          color: AppColors.sunsetOrange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: NeonStatCard(
                          title: 'Next Appt',
                          value: dashboardState.nextAppointment ?? 'None',
                          subtitle: 'Health checkup',
                          icon: PhosphorIcons.calendarCheck(),
                          color: AppColors.assurancePrimary,
                          onTap: () => context.go('/assurance'),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
                ],
              ),
            ),
          ),

          // AI Recommendations
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: AppColors.neonGlowGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          PhosphorIcons.sparkle(),
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'AI Recommendations',
                        style: AppTextStyles.h4,
                      ),
                    ],
                  ).animate().fadeIn(delay: 600.ms),
                  const SizedBox(height: 16),
                  ...dashboardState.aiRecommendations.map((rec) => _buildRecommendationCard(rec)),
                ],
              ),
            ),
          ),

          // Progress Overview
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Progress',
                    style: AppTextStyles.h4,
                  ).animate().fadeIn(delay: 700.ms),
                  const SizedBox(height: 16),
                  _buildProgressSection(context, dashboardState),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIInsightBanner(BuildContext context, WidgetRef ref) {
    return NeonCard(
      gradient: LinearGradient(
        colors: [
          AppColors.electricPurple.withOpacity(0.3),
          AppColors.neonPink.withOpacity(0.3),
        ],
      ),
      glowColor: AppColors.electricPurple,
      onTap: () => context.go('/ai'),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppColors.neonGlowGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonPink.withOpacity(0.3),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Icon(
              PhosphorIcons.brain(),
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Insight',
                  style: AppTextStyles.h5.copyWith(color: AppColors.cyan),
                ),
                const SizedBox(height: 4),
                Text(
                  'You\'re 23% more active this week. Keep it up! 💪',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
          Icon(
            PhosphorIcons.caretRight(),
            color: AppColors.textMuted,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).shimmer(duration: 2000.ms);
  }

  Widget _buildRecommendationCard(AIRecommendation rec) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: NeonCard(
        glowColor: rec.color,
        onTap: rec.onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: rec.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(rec.icon, color: rec.color, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rec.title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    rec.description,
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: rec.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: rec.color.withOpacity(0.5)),
              ),
              child: Text(
                rec.category,
                style: AppTextStyles.caption.copyWith(color: rec.color),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 700.ms).slideX(begin: 0.1);
  }

  Widget _buildProgressSection(BuildContext context, DashboardState state) {
    return NeonCard(
      child: Column(
        children: [
          _buildProgressRow('Fitness', state.fitnessProgress, AppColors.fitnessPrimary),
          const SizedBox(height: 16),
          _buildProgressRow('Finance', state.financeProgress, AppColors.financePrimary),
          const SizedBox(height: 16),
          _buildProgressRow('Health', state.healthProgress, AppColors.assurancePrimary),
        ],
      ),
    );
  }

  Widget _buildProgressRow(String label, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.bodyMedium),
            Text(
              '${(progress * 100).toInt()}%',
              style: AppTextStyles.bodyMedium.copyWith(color: color),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.backgroundCardLight,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [color, color.withOpacity(0.6)]),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
