import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/fitness/providers/fitness_provider.dart';
import '../../features/finance/providers/finance_provider.dart';
import '../../features/assurance/providers/assurance_provider.dart';

/// Aggregates data from all three pillars for holistic AI analysis
class DataAggregator {
  final Ref ref;

  DataAggregator(this.ref);

  /// Get fitness data formatted for AI context
  Map<String, dynamic> getFitnessContext() {
    final fitness = ref.read(fitnessProvider);
    return {
      'steps_today': fitness.steps,
      'steps_goal': fitness.stepsGoal,
      'steps_percentage': (fitness.stepsPercentage * 100).toStringAsFixed(0),
      'calories_burned': fitness.caloriesBurned,
      'active_minutes': fitness.activeMinutes,
      'workout_count': fitness.workoutCount,
      'consumed_calories': fitness.consumedCalories,
      'calories_remaining': fitness.caloriesRemaining,
      'mood_rating': fitness.moodRating,
      'energy_level': fitness.energyLevel,
      'stress_level': fitness.stressLevel,
    };
  }

  /// Get finance data formatted for AI context
  Map<String, dynamic> getFinanceContext() {
    final finance = ref.read(financeProvider);
    final topCategories = finance.topSpendingCategories;
    return {
      'total_balance': finance.totalBalance,
      'monthly_income': finance.monthlyIncome,
      'monthly_expenses': finance.monthlyExpenses,
      'net_cashflow': finance.netCashflow,
      'savings_rate': (finance.savingsRate * 100).toStringAsFixed(0),
      'transaction_count': finance.transactions.length,
      'top_spending_category': topCategories.isNotEmpty ? topCategories.first.key : null,
      'top_spending_amount': topCategories.isNotEmpty ? topCategories.first.value : null,
      'budget_count': finance.budgets.length,
      'savings_goals_count': finance.savingsGoals.length,
      'total_subscriptions': finance.totalSubscriptions,
      'is_over_budget': finance.isOverBudget,
    };
  }

  /// Get health/assurance data formatted for AI context
  Map<String, dynamic> getAssuranceContext() {
    final assurance = ref.read(assuranceProvider);
    return {
      'blood_pressure': assurance.bloodPressure ?? 'Not recorded',
      'blood_pressure_status': assurance.hasHighBloodPressure ? 'elevated' : 'normal',
      'weight_lbs': assurance.weight,
      'bmi': assurance.bmi?.toStringAsFixed(1) ?? 'Not calculated',
      'resting_heart_rate': assurance.restingHeartRate,
      'upcoming_appointments': assurance.upcomingAppointments.length,
      'next_appointment': assurance.nextAppointment != null 
        ? '${assurance.nextAppointment!.doctorName} in ${assurance.nextAppointment!.daysUntil} days'
        : 'None scheduled',
      'active_medications': assurance.activeMedications,
      'medications_needing_refill': assurance.medicationsNeedingRefill.length,
      'insurance_policies': assurance.policies.length,
    };
  }

  /// Get holistic context for AI (all pillars combined)
  Map<String, dynamic> getHolisticContext() {
    return {
      'fitness': getFitnessContext(),
      'finance': getFinanceContext(),
      'health': getAssuranceContext(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Generate cross-pillar insights
  Future<List<CrossPillarInsight>> generateCrossPillarInsights() async {
    final fitness = ref.read(fitnessProvider);
    final finance = ref.read(financeProvider);
    final assurance = ref.read(assuranceProvider);

    final insights = <CrossPillarInsight>[];

    // Stress correlation: spending vs health
    final savingsRate = finance.savingsRate;
    final stressLevel = fitness.stressLevel;
    
    if (savingsRate < 0.20 && stressLevel != null && stressLevel > 6) {
      insights.add(const CrossPillarInsight(
        title: 'Financial Stress Impact',
        description: 'Your savings rate is below 20% and stress levels are elevated. Financial stress can impact health. Consider reviewing your budget.',
        pillars: [InsightPillar.finance, InsightPillar.health],
        severity: InsightSeverity.warning,
        actionable: true,
        action: 'Review Budget',
      ));
    }

    // Activity vs Spending correlation
    final steps = fitness.steps;
    final stepsGoal = fitness.stepsGoal;
    if (steps < stepsGoal * 0.7) {
      final topCategory = finance.topSpendingCategories.isNotEmpty 
        ? finance.topSpendingCategories.first.key 
        : 'entertainment';
      insights.add(CrossPillarInsight(
        title: 'Boost Activity, Boost Savings',
        description: 'You\'re below 70% of your step goal. Adding a daily walk could improve health AND reduce spending on $topCategory.',
        pillars: [InsightPillar.fitness, InsightPillar.finance],
        severity: InsightSeverity.suggestion,
        actionable: true,
        action: 'Create Walking Routine',
      ));
    }

    // Health appointments vs finance
    final upcomingAppts = assurance.upcomingAppointments.length;
    if (upcomingAppts == 0 && assurance.policies.isNotEmpty) {
      insights.add(const CrossPillarInsight(
        title: 'Preventive Care Saves Money',
        description: 'No upcoming health appointments. Regular checkups catch issues early and reduce long-term healthcare costs.',
        pillars: [InsightPillar.health, InsightPillar.finance],
        severity: InsightSeverity.suggestion,
        actionable: true,
        action: 'Schedule Checkup',
      ));
    }

    // Positive reinforcement
    if (savingsRate > 0.30 && steps > stepsGoal * 0.8) {
      insights.add(CrossPillarInsight(
        title: 'Excellent Balance! 🌟',
        description: 'You\'re crushing it! ${(savingsRate * 100).toInt()}% savings rate and ${steps} steps today. You\'re optimizing both wealth and health.',
        pillars: [InsightPillar.fitness, InsightPillar.finance, InsightPillar.health],
        severity: InsightSeverity.positive,
        actionable: false,
      ));
    }

    return insights;
  }
}

class CrossPillarInsight {
  final String title;
  final String description;
  final List<InsightPillar> pillars;
  final InsightSeverity severity;
  final bool actionable;
  final String? action;

  const CrossPillarInsight({
    required this.title,
    required this.description,
    required this.pillars,
    required this.severity,
    required this.actionable,
    this.action,
  });
}

enum InsightPillar {
  fitness,
  finance,
  health,
}

enum InsightSeverity {
  positive,
  suggestion,
  warning,
  critical,
}

/// Provider for DataAggregator
final dataAggregatorProvider = Provider<DataAggregator>((ref) {
  return DataAggregator(ref);
});

/// Provider for cross-pillar insights
final crossPillarInsightsProvider = FutureProvider<List<CrossPillarInsight>>((ref) async {
  final aggregator = ref.watch(dataAggregatorProvider);
  return aggregator.generateCrossPillarInsights();
});
