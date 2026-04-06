import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/neon_card.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../providers/fitness_provider.dart';

class FitnessPage extends ConsumerStatefulWidget {
  const FitnessPage({super.key});

  @override
  ConsumerState<FitnessPage> createState() => _FitnessPageState();
}

class _FitnessPageState extends ConsumerState<FitnessPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fitnessState = ref.watch(fitnessProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.backgroundDarker,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.fitnessPrimary.withOpacity(0.3),
                      AppColors.backgroundDarker,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => AppColors.fitnessGradient.createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: Text(
                            'Fitness',
                            style: AppTextStyles.h1.copyWith(color: Colors.white),
                          ),
                        ).animate().fadeIn(),
                        const SizedBox(height: 8),
                        Text(
                          'AI-powered health & fitness tracking',
                          style: AppTextStyles.bodyMedium,
                        ).animate().fadeIn(delay: 200.ms),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.fitnessPrimary,
              labelColor: AppColors.fitnessPrimary,
              unselectedLabelColor: AppColors.textMuted,
              tabs: [
                Tab(icon: Icon(PhosphorIcons.chartLine())),
                Tab(icon: Icon(PhosphorIcons.barbell())),
                Tab(icon: Icon(PhosphorIcons.forkKnife())),
                Tab(icon: Icon(PhosphorIcons.sparkle())),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(fitnessState),
            _buildWorkoutsTab(),
            _buildNutritionTab(),
            _buildAICoachTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab(FitnessState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's Stats
          Row(
            children: [
              Expanded(
                child: NeonStatCard(
                  title: 'Steps',
                  value: state.steps.toString(),
                  subtitle: '/ ${state.stepsGoal}',
                  icon: PhosphorIcons.footprints(),
                  color: AppColors.fitnessPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeonStatCard(
                  title: 'Calories',
                  value: state.caloriesBurned.toString(),
                  subtitle: 'burned',
                  icon: PhosphorIcons.fire(),
                  color: AppColors.sunsetOrange,
                ),
              ),
            ],
          ).animate().fadeIn().slideY(begin: 0.1),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: NeonStatCard(
                  title: 'Active Minutes',
                  value: state.activeMinutes.toString(),
                  subtitle: 'min',
                  icon: PhosphorIcons.timer(),
                  color: AppColors.electricPurple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeonStatCard(
                  title: 'Heart Rate',
                  value: '${state.todayData?.restingHeartRate ?? 0}',
                  subtitle: 'bpm avg',
                  icon: PhosphorIcons.heartbeat(),
                  color: AppColors.neonPink,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),

          // Weekly Activity Chart
          const SizedBox(height: 24),
          Text('Weekly Activity', style: AppTextStyles.h4).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 16),
          NeonCard(
            glowColor: AppColors.fitnessPrimary,
            child: SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10000,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                          return Text(
                            days[value.toInt()],
                            style: AppTextStyles.caption,
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups: state.last7Days.map((d) => d.steps.toDouble()).toList().asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          gradient: AppColors.fitnessGradient,
                          width: 20,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),

          // AI Insight
          const SizedBox(height: 24),
          _buildAIInsight(state.aiInsight ?? '').animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildWorkoutsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Start', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildWorkoutTypeCard('Run', PhosphorIcons.personSimpleRun(), AppColors.fitnessPrimary),
              _buildWorkoutTypeCard('Walk', PhosphorIcons.personSimpleWalk(), AppColors.cyan),
              _buildWorkoutTypeCard('Cycle', PhosphorIcons.bicycle(), AppColors.electricPurple),
              _buildWorkoutTypeCard('Gym', PhosphorIcons.barbell(), AppColors.neonPink),
            ],
          ),
          const SizedBox(height: 24),
          Text('AI-Suggested Workouts', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          _buildSuggestedWorkout(
            'Full Body HIIT',
            '20 min • High intensity',
            'Based on your goals',
            PhosphorIconsFill.lightning,
          ),
          _buildSuggestedWorkout(
            'Recovery Yoga',
            '15 min • Low intensity',
            'You seem stressed today',
            PhosphorIcons.flowerLotus(),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: NeonStatCard(
                  title: 'Calories',
                  value: '1,450',
                  subtitle: 'Remaining: 550',
                  icon: PhosphorIcons.fire(),
                  color: AppColors.sunsetOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Macros', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildMacroCard('Protein', 65, 120, AppColors.fitnessPrimary)),
              const SizedBox(width: 12),
              Expanded(child: _buildMacroCard('Carbs', 180, 250, AppColors.cyan)),
              const SizedBox(width: 12),
              Expanded(child: _buildMacroCard('Fat', 45, 65, AppColors.neonPink)),
            ],
          ),
          const SizedBox(height: 24),
          GradientButton(
            text: 'Log Meal with AI',
            icon: PhosphorIcons.camera(),
            gradient: AppColors.sunsetGradient,
          ),
        ],
      ),
    );
  }

  Widget _buildAICoachTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NeonCard(
            gradient: LinearGradient(
              colors: [
                AppColors.fitnessPrimary.withOpacity(0.2),
                AppColors.electricPurple.withOpacity(0.2),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: AppColors.fitnessGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(PhosphorIcons.brain(), size: 32, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text('AI Fitness Coach', style: AppTextStyles.h3),
                const SizedBox(height: 8),
                Text(
                  'Get personalized workout plans, form feedback, and motivation',
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                GradientButton(
                  text: 'Start Chat',
                  icon: PhosphorIcons.chatCircle(),
                  gradient: AppColors.fitnessGradient,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Quick Questions', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          _buildQuickQuestion('How can I improve my running pace?'),
          _buildQuickQuestion('What should I eat before a workout?'),
          _buildQuickQuestion('How do I prevent injury?'),
        ],
      ),
    );
  }

  Widget _buildAIInsight(String insight) {
    return NeonCard(
      gradient: LinearGradient(
        colors: [
          AppColors.cyan.withOpacity(0.2),
          AppColors.electricPurple.withOpacity(0.2),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cyan.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(PhosphorIcons.sparkle(), color: AppColors.cyan),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Insight', style: AppTextStyles.h5.copyWith(color: AppColors.cyan)),
                const SizedBox(height: 4),
                Text(insight, style: AppTextStyles.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutTypeCard(String title, IconData icon, Color color) {
    return NeonCard(
      glowColor: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(title, style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedWorkout(String title, String duration, String reason, IconData icon) {
    return NeonCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.fitnessPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.fitnessPrimary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                Text(duration, style: AppTextStyles.bodySmall),
                Text(reason, style: AppTextStyles.caption.copyWith(color: AppColors.fitnessPrimary)),
              ],
            ),
          ),
          Icon(PhosphorIconsFill.playCircle, color: AppColors.fitnessPrimary),
        ],
      ),
    );
  }

  Widget _buildMacroCard(String name, int current, int target, Color color) {
    return NeonCard(
      glowColor: color,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text('${(current / target * 100).toInt()}%', style: AppTextStyles.h4.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(name, style: AppTextStyles.caption),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: current / target,
            backgroundColor: AppColors.backgroundCardLight,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: NeonCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(child: Text(question, style: AppTextStyles.bodyMedium)),
            Icon(PhosphorIcons.caretRight(), color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}
