import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/fitness/providers/fitness_provider.dart';
import '../../features/finance/providers/finance_provider.dart';
import '../../features/assurance/providers/assurance_provider.dart';
import 'ai_service.dart';

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
      'steps_percentage': (fitness.steps / fitness.stepsGoal * 100).toStringAsFixed(0),
      'calories_burned': fitness.caloriesBurned,
      'active_minutes': fitness.activeMinutes,
      'heart_rate_avg': fitness.heartRate,
      'weekly_steps': fitness.weeklySteps,
      'weekly_avg_steps': (fitness.weeklySteps.reduce((a, b) => a + b) / fitness.weeklySteps.length).toInt(),
    };
  }

  /// Get finance data formatted for AI context
  Map<String, dynamic> getFinanceContext() {
    final finance = ref.read(financeProvider);
    return {
      'total_balance': finance.totalBalance,
      'monthly_income': finance.monthlyIncome,
      'monthly_expenses': finance.monthlyExpenses,
      'savings_rate': ((finance.monthlyIncome - finance.monthlyExpenses) / finance.monthlyIncome * 100).toStringAsFixed(0),
      'top_spending_category': finance.spendingCategories.first.name,
      'top_spending_amount': finance.spendingCategories.first.amount,
      'budgets': finance.budgets.map((b) => {
        'name': b.name,
        'spent': b.spent,
        'limit': b.limit,
        'percentage': (b.spent / b.limit * 100).toStringAsFixed(0),
      }).toList(),
      'savings_goals': finance.savingsGoals.map((g) => {
        'name': g.name,
        'current': g.current,
        'target': g.target,
        'progress': (g.current / g.target * 100).toStringAsFixed(0),
      }).toList(),
    };
  }

  /// Get health/assurance data formatted for AI context
  Map<String, dynamic> getAssuranceContext() {
    final assurance = ref.read(assuranceProvider);
    return {
      'blood_pressure': '${assurance.bloodPressureSystolic}/${assurance.bloodPressureDiastolic}',
      'blood_pressure_status': _getBPStatus(assurance.bloodPressureSystolic, assurance.bloodPressureDiastolic),
      'weight_lbs': assurance.weight,
      'upcoming_appointments': assurance.upcomingAppointments.length,
      'next_appointment': assurance.upcomingAppointments.isNotEmpty
          ? '${assurance.upcomingAppointments.first.doctorName} in ${assurance.upcomingAppointments.first.daysUntil} days'
          : 'None scheduled',
      'active_medications': assurance.medications.length,
      'insurance_policies': assurance.insurancePolicies.length,
    };
  }

  String _getBPStatus(int systolic, int diastolic) {
    if (systolic < 120 && diastolic < 80) return 'normal';
    if (systolic < 130 && diastolic < 80) return 'elevated';
    if (systolic < 140 || diastolic < 90) return 'high stage 1';
    return 'high stage 2';
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
    final fitness = getFitnessContext();
    final finance = getFinanceContext();
    final health = getAssuranceContext();

    final insights = <CrossPillarInsight>[];

    // Stress correlation: spending vs health
    final savingsRate = double.parse(finance['savings_rate']);
    if (savingsRate < 20) {
      insights.add(CrossPillarInsight(
        title: 'Financial Stress Impact',
        description: 'Your savings rate is below 20%. Studies show financial stress can impact health. Consider reviewing your budget.',
        pillars: [InsightPillar.finance, InsightPillar.health],
        severity: InsightSeverity.warning,
        actionable: true,
        action: 'Review Budget',
      ));
    }

    // Activity vs Spending correlation
    final weeklyAvgSteps = fitness['weekly_avg_steps'] as int;
    if (weeklyAvgSteps < 7000) {
      final topSpending = finance['top_spending_category'];
      insights.add(CrossPillarInsight(
        title: 'Boost Activity, Boost Savings',
        description: 'You\'re averaging $weeklyAvgSteps steps/day. Adding a daily walk could improve health AND reduce spending on ${topSpending}.',
        pillars: [InsightPillar.fitness, InsightPillar.finance],
        severity: InsightSeverity.suggestion,
        actionable: true,
        action: 'Create Walking Routine',
      ));
    }

    // Health appointments vs finance
    final upcomingAppts = health['upcoming_appointments'] as int;
    if (upcomingAppts == 0) {
      insights.add(CrossPillarInsight(
        title: 'Preventive Care Saves Money',
        description: 'No upcoming health appointments. Regular checkups catch issues early and reduce long-term healthcare costs.',
        pillars: [InsightPillar.health, InsightPillar.finance],
        severity: InsightSeverity.suggestion,
        actionable: true,
        action: 'Schedule Checkup',
      ));
    }

    // Positive reinforcement
    if (savingsRate > 30 && weeklyAvgSteps > 8000) {
      insights.add(CrossPillarInsight(
        title: 'Excellent Balance! 🌟',
        description: 'You\'re crushing it! ${savingsRate.toStringAsFixed(0)}% savings rate and ${weeklyAvgSteps} avg steps/day. You\'re optimizing both wealth and health.',
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
