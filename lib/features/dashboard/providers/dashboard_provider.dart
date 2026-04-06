import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../fitness/providers/fitness_provider.dart';
import '../../fitness/data/fitness_repository.dart';
import '../../finance/providers/finance_provider.dart';
import '../../finance/data/finance_repository.dart';
import '../../assurance/providers/assurance_provider.dart';
import '../../assurance/data/assurance_repository.dart';
import '../../../shared/models/fitness_data.dart';
import '../../../shared/models/finance_data.dart';
import '../../../shared/models/assurance_data.dart';
import '../../../core/services/data_aggregator.dart';
import '../../../core/theme/app_colors.dart';

class AIRecommendation {
  final String title;
  final String description;
  final String category;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const AIRecommendation({
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
    required this.color,
    this.onTap,
  });
}

class DashboardState {
  final int stepsToday;
  final String budgetRemaining;
  final int caloriesToday;
  final int caloriesRemaining;
  final String? nextAppointment;
  final double fitnessProgress;
  final double financeProgress;
  final double healthProgress;
  final List<AIRecommendation> aiRecommendations;
  final List<CrossPillarInsight> crossPillarInsights;
  final bool isLoading;

  const DashboardState({
    this.stepsToday = 0,
    this.budgetRemaining = '0.00',
    this.caloriesToday = 0,
    this.caloriesRemaining = 0,
    this.nextAppointment,
    this.fitnessProgress = 0.0,
    this.financeProgress = 0.0,
    this.healthProgress = 0.0,
    this.aiRecommendations = const [],
    this.crossPillarInsights = const [],
    this.isLoading = false,
  });

  DashboardState copyWith({
    int? stepsToday,
    String? budgetRemaining,
    int? caloriesToday,
    int? caloriesRemaining,
    String? nextAppointment,
    double? fitnessProgress,
    double? financeProgress,
    double? healthProgress,
    List<AIRecommendation>? aiRecommendations,
    List<CrossPillarInsight>? crossPillarInsights,
    bool? isLoading,
  }) {
    return DashboardState(
      stepsToday: stepsToday ?? this.stepsToday,
      budgetRemaining: budgetRemaining ?? this.budgetRemaining,
      caloriesToday: caloriesToday ?? this.caloriesToday,
      caloriesRemaining: caloriesRemaining ?? this.caloriesRemaining,
      nextAppointment: nextAppointment ?? this.nextAppointment,
      fitnessProgress: fitnessProgress ?? this.fitnessProgress,
      financeProgress: financeProgress ?? this.financeProgress,
      healthProgress: healthProgress ?? this.healthProgress,
      aiRecommendations: aiRecommendations ?? this.aiRecommendations,
      crossPillarInsights: crossPillarInsights ?? this.crossPillarInsights,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class DashboardNotifier extends StateNotifier<DashboardState> {
  final FitnessRepository _fitnessRepo;
  final FinanceRepository _financeRepo;
  final AssuranceRepository _assuranceRepo;
  final DataAggregator _aggregator;

  DashboardNotifier(
    this._fitnessRepo,
    this._financeRepo,
    this._assuranceRepo,
    this._aggregator,
  ) : super(const DashboardState()) {
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    state = state.copyWith(isLoading: true);

    try {
      // Get data from all repositories
      final fitness = _fitnessRepo.todayData;
      final finance = _financeRepo.currentMonthData;
      final assurance = _assuranceRepo.currentData;

      // Calculate progress
      final fitnessProgress = fitness.stepsGoal > 0 
        ? fitness.steps / fitness.stepsGoal 
        : 0.0;
      
      final financeProgress = finance.monthlyIncome > 0
        ? (finance.monthlyIncome - finance.monthlyExpenses) / finance.monthlyIncome
        : 0.0;
      
      final healthProgress = _calculateHealthProgress(assurance);

      // Get next appointment
      final nextAppt = _assuranceRepo.getUpcomingAppointments().firstOrNull;

      // Generate AI recommendations
      final recommendations = _generateRecommendations(fitness, finance, assurance);

      // Generate cross-pillar insights
      final insights = await _aggregator.generateCrossPillarInsights();

      state = state.copyWith(
        isLoading: false,
        stepsToday: fitness.steps,
        budgetRemaining: finance.netCashflow.toStringAsFixed(2),
        caloriesToday: fitness.consumedCalories,
        caloriesRemaining: fitness.caloriesRemaining,
        nextAppointment: nextAppt != null 
          ? '${nextAppt.doctorName} (${nextAppt.daysUntil} days)'
          : null,
        fitnessProgress: fitnessProgress.clamp(0.0, 1.0),
        financeProgress: financeProgress.clamp(0.0, 1.0),
        healthProgress: healthProgress,
        aiRecommendations: recommendations,
        crossPillarInsights: insights,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  double _calculateHealthProgress(AssuranceData data) {
    var score = 0.0;
    var factors = 0;
    
    if (data.bloodPressureSystolic != null && data.bloodPressureDiastolic != null) {
      if (!data.hasHighBloodPressure) score += 1.0;
      factors++;
    }
    
    if (data.activeMedications > 0) {
      score += 0.5; // Taking prescribed medications
      factors++;
    }

    if (data.upcomingAppointments > 0) {
      score += 0.5; // Has upcoming care
      factors++;
    }
    
    return factors > 0 ? score / factors : 0.5;
  }

  List<AIRecommendation> _generateRecommendations(
    FitnessData fitness,
    FinanceData finance,
    AssuranceData assurance,
  ) {
    final recommendations = <AIRecommendation>[];

    // Fitness recommendations
    if (!fitness.hitStepsGoal && fitness.stepsPercentage < 0.5) {
      recommendations.add(AIRecommendation(
        title: 'Get Moving',
        description: 'You\'re at ${(fitness.stepsPercentage * 100).toInt()}% of your step goal. A 10-minute walk will help!',
        category: 'Fitness',
        icon: PhosphorIcons.footprints(),
        color: AppColors.fitnessPrimary,
      ));
    }

    // Finance recommendations
    if (finance.isOverBudget) {
      recommendations.add(AIRecommendation(
        title: 'Budget Alert',
        description: 'You\'re over budget this month. Review your spending in ${finance.spendingByCategory.entries.firstOrNull?.key ?? 'top categories'}.',
        category: 'Finance',
        icon: PhosphorIcons.warning(),
        color: AppColors.warning,
      ));
    }

    final unusedSubs = finance.subscriptions.where((s) => s.isUnused).toList();
    if (unusedSubs.isNotEmpty) {
      final savings = unusedSubs.fold(0.0, (sum, s) => sum + s.monthlyCost);
      recommendations.add(AIRecommendation(
        title: 'Cut Unused Subscriptions',
        description: 'Save \$${savings.toStringAsFixed(2)}/month by canceling ${unusedSubs.length} unused subscriptions.',
        category: 'Finance',
        icon: PhosphorIcons.scissors(),
        color: AppColors.financePrimary,
      ));
    }

    // Health recommendations
    if (assurance.medicationsNeedingRefill.isNotEmpty) {
      recommendations.add(AIRecommendation(
        title: 'Refill Medications',
        description: '${assurance.medicationsNeedingRefill.length} medication(s) need refill. Don\'t wait until you run out!',
        category: 'Health',
        icon: PhosphorIcons.pill(),
        color: AppColors.assurancePrimary,
      ));
    }

    if (assurance.upcomingAppointments == 0) {
      recommendations.add(AIRecommendation(
        title: 'Schedule Checkup',
        description: 'No upcoming appointments. Preventive care is key to long-term health.',
        category: 'Health',
        icon: PhosphorIcons.calendarPlus(),
        color: AppColors.info,
      ));
    }

    return recommendations;
  }

  Future<void> refresh() async {
    await _loadDashboardData();
  }
}

// Provider
final dashboardProvider = StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier(
    ref.watch(fitnessRepositoryProvider),
    ref.watch(financeRepositoryProvider),
    ref.watch(assuranceRepositoryProvider),
    ref.watch(dataAggregatorProvider),
  );
});
