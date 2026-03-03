import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../main.dart';
import '../../data/finance_repository.dart';
import '../../../shared/models/finance_data.dart';
import '../../../core/theme/app_colors.dart';

class FinanceState {
  final FinanceData? currentMonthData;
  final List<FinanceData> last6Months;
  final Map<String, dynamic> statsForAI;
  final String? aiInsight;
  final bool isLoading;
  final String? error;

  const FinanceState({
    this.currentMonthData,
    this.last6Months = const [],
    this.statsForAI = const {},
    this.aiInsight,
    this.isLoading = false,
    this.error,
  });

  FinanceState copyWith({
    FinanceData? currentMonthData,
    List<FinanceData>? last6Months,
    Map<String, dynamic>? statsForAI,
    String? aiInsight,
    bool? isLoading,
    String? error,
  }) {
    return FinanceState(
      currentMonthData: currentMonthData ?? this.currentMonthData,
      last6Months: last6Months ?? this.last6Months,
      statsForAI: statsForAI ?? this.statsForAI,
      aiInsight: aiInsight ?? this.aiInsight,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  // Computed getters
  double get totalBalance => currentMonthData?.totalBalance ?? 0;
  double get monthlyIncome => currentMonthData?.monthlyIncome ?? 0;
  double get monthlyExpenses => currentMonthData?.monthlyExpenses ?? 0;
  double get netCashflow => currentMonthData?.netCashflow ?? 0;
  double get savingsRate => currentMonthData?.savingsRate ?? 0;
  List<Transaction> get transactions => currentMonthData?.transactions ?? [];
  List<Transaction> get recentTransactions => transactions.take(5).toList();
  List<Budget> get budgets => currentMonthData?.budgets ?? [];
  List<SavingsGoal> get savingsGoals => currentMonthData?.savingsGoals ?? [];
  List<Subscription> get subscriptions => currentMonthData?.subscriptions ?? [];
  double get totalSubscriptions => currentMonthData?.totalSubscriptions ?? 0;
  bool get isOverBudget => currentMonthData?.isOverBudget ?? false;
  
  Map<String, double> get spendingByCategory => currentMonthData?.spendingByCategory ?? {};
  
  List<MapEntry<String, double>> get topSpendingCategories {
    final entries = spendingByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.take(5).toList();
  }
}

class FinanceNotifier extends StateNotifier<FinanceState> {
  final FinanceRepository _repository;

  FinanceNotifier(this._repository) : super(const FinanceState()) {
    _loadFinanceData();
  }

  Future<void> _loadFinanceData() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final currentMonth = _repository.currentMonthData;
      final last6Months = _repository.getLastNMonths(6);
      final statsForAI = _repository.getStatsForAI();
      
      final aiInsight = _generateAIInsight(currentMonth);
      
      state = state.copyWith(
        currentMonthData: currentMonth,
        last6Months: last6Months,
        statsForAI: statsForAI,
        aiInsight: aiInsight,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load finance data: $e',
      );
    }
  }

  Future<void> addTransaction({
    required String name,
    required String category,
    required double amount,
    required bool isExpense,
    String? merchant,
    String? notes,
  }) async {
    final transaction = Transaction(
      name: name,
      category: category,
      amount: amount,
      isExpense: isExpense,
      merchant: merchant,
      notes: notes,
    );
    
    await _repository.addTransaction(DateTime.now(), transaction);
    await _loadFinanceData();
  }

  Future<void> updateBudget(Budget budget) async {
    await _repository.updateBudget(DateTime.now(), budget);
    await _loadFinanceData();
  }

  Future<void> updateSavingsGoal(SavingsGoal goal) async {
    await _repository.updateSavingsGoal(goal);
    await _loadFinanceData();
  }

  Future<void> updateSubscription(Subscription subscription) async {
    await _repository.updateSubscription(subscription);
    await _loadFinanceData();
  }

  Future<void> refresh() async {
    await _loadFinanceData();
  }

  String _generateAIInsight(FinanceData? data) {
    if (data == null) return 'Start tracking your finances to get personalized insights!';
    
    final savingsRate = (data.savingsRate * 100).round();
    final unusedSubs = data.subscriptions.where((s) => s.isUnused).length;
    
    if (unusedSubs > 0) {
      final potentialSavings = data.subscriptions
        .where((s) => s.isUnused)
        .fold(0.0, (sum, s) => sum + s.monthlyCost);
      return '💡 You have $unusedSubs unused subscriptions. Canceling them could save \$${potentialSavings.toStringAsFixed(0)}/month!';
    }
    
    if (savingsRate >= 30) {
      return '🎉 Excellent! You\'re saving $savingsRate% of your income. You\'re on track for financial freedom!';
    } else if (savingsRate >= 20) {
      return '👍 Good job! You\'re saving $savingsRate% of your income. Keep it up!';
    } else if (savingsRate >= 10) {
      return 'You\'re saving $savingsRate% of your income. Try to bump it to 20% for better financial security.';
    } else {
      return '⚠️ You\'re only saving $savingsRate% of your income. Consider reviewing your expenses to increase savings.';
    }
  }

  Map<String, dynamic> getDataForAI() {
    return state.statsForAI;
  }
}

// Helper extension for UI
extension TransactionUI on Transaction {
  IconData get icon {
    return switch (category.toLowerCase()) {
      'food' || 'dining' || 'groceries' => PhosphorIcons.forkKnife,
      'transport' || 'gas' || 'car' => PhosphorIcons.car,
      'entertainment' || 'movies' || 'games' => PhosphorIcons.gameController,
      'shopping' || 'clothes' => PhosphorIcons.shoppingBag,
      'housing' || 'rent' || 'mortgage' => PhosphorIcons.house,
      'health' || 'medical' => PhosphorIcons.heart,
      'income' || 'salary' => PhosphorIcons.money,
      _ => isExpense ? PhosphorIcons.minus : PhosphorIcons.plus,
    };
  }

  Color get color {
    return switch (category.toLowerCase()) {
      'food' || 'dining' => AppColors.sunsetOrange,
      'transport' => AppColors.cyan,
      'entertainment' => AppColors.neonPink,
      'shopping' => AppColors.financePrimary,
      'housing' => AppColors.electricPurple,
      'health' => AppColors.assurancePrimary,
      _ => isExpense ? AppColors.error : AppColors.success,
    };
  }
}

final financeProvider = StateNotifierProvider<FinanceNotifier, FinanceState>((ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return FinanceNotifier(repository);
});
