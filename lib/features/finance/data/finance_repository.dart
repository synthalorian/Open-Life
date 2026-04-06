import 'package:hive/hive.dart';
import '../../../shared/models/finance_data.dart';

class FinanceRepository {
  static const String _boxName = 'finance_data';
  Box<FinanceData>? _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<FinanceData>(_boxName);
    } else {
      _box = Hive.box<FinanceData>(_boxName);
    }
  }

  Box<FinanceData> get box {
    if (_box == null) throw StateError('FinanceRepository not initialized. Call init() first.');
    return _box!;
  }

  // Monthly data
  Future<void> saveMonthlyData(FinanceData data) async {
    final key = _monthKey(data.date);
    await box.put(key, data);
  }

  FinanceData? getMonthlyData(DateTime date) {
    return box.get(_monthKey(date));
  }

  FinanceData getOrCreateMonthlyData(DateTime date) {
    final key = _monthKey(date);
    return box.get(key) ?? FinanceData(date: date);
  }

  // Current month (convenience)
  FinanceData get currentMonthData => getOrCreateMonthlyData(DateTime.now());

  // Transactions
  Future<void> addTransaction(DateTime month, Transaction transaction) async {
    final data = getOrCreateMonthlyData(month);
    final updatedTransactions = [...data.transactions, transaction];
    
    // Update monthly expenses/income
    double newExpenses = data.monthlyExpenses;
    double newIncome = data.monthlyIncome;
    
    if (transaction.isExpense) {
      newExpenses += transaction.amount;
    } else {
      newIncome += transaction.amount;
    }

    final updated = data.copyWith(
      transactions: updatedTransactions,
      monthlyExpenses: newExpenses,
      monthlyIncome: newIncome,
    );
    
    await saveMonthlyData(updated);
  }

  Future<void> updateTransaction(DateTime month, String transactionId, Transaction updatedTransaction) async {
    final data = getOrCreateMonthlyData(month);
    final updatedTransactions = data.transactions.map((t) =>
      t.id == transactionId ? updatedTransaction : t
    ).toList();

    // Recalculate totals
    final newExpenses = updatedTransactions
      .where((t) => t.isExpense)
      .fold(0.0, (sum, t) => sum + t.amount);

    final newIncome = updatedTransactions
      .where((t) => !t.isExpense)
      .fold(0.0, (sum, t) => sum + t.amount);

    final updated = data.copyWith(
      transactions: updatedTransactions,
      monthlyExpenses: newExpenses,
      monthlyIncome: newIncome,
    );

    await saveMonthlyData(updated);
  }

  // Budgets
  Future<void> updateBudget(DateTime month, Budget budget) async {
    final data = getOrCreateMonthlyData(month);
    final existingIndex = data.budgets.indexWhere((b) => b.id == budget.id);
    
    List<Budget> updatedBudgets;
    if (existingIndex >= 0) {
      updatedBudgets = [...data.budgets];
      updatedBudgets[existingIndex] = budget;
    } else {
      updatedBudgets = [...data.budgets, budget];
    }

    final updated = data.copyWith(budgets: updatedBudgets);
    await saveMonthlyData(updated);
  }

  // Savings goals (global, not monthly)
  Future<void> updateSavingsGoal(SavingsGoal goal) async {
    final data = currentMonthData;
    final existingIndex = data.savingsGoals.indexWhere((g) => g.id == goal.id);
    
    List<SavingsGoal> updatedGoals;
    if (existingIndex >= 0) {
      updatedGoals = [...data.savingsGoals];
      updatedGoals[existingIndex] = goal;
    } else {
      updatedGoals = [...data.savingsGoals, goal];
    }

    final updated = data.copyWith(savingsGoals: updatedGoals);
    await saveMonthlyData(updated);
  }

  // Subscriptions (global)
  Future<void> updateSubscription(Subscription subscription) async {
    final data = currentMonthData;
    final existingIndex = data.subscriptions.indexWhere((s) => s.id == subscription.id);
    
    List<Subscription> updatedSubs;
    if (existingIndex >= 0) {
      updatedSubs = [...data.subscriptions];
      updatedSubs[existingIndex] = subscription;
    } else {
      updatedSubs = [...data.subscriptions, subscription];
    }

    final updated = data.copyWith(subscriptions: updatedSubs);
    await saveMonthlyData(updated);
  }

  // Historical data
  List<FinanceData> getLastNMonths(int months) {
    final result = <FinanceData>[];
    final now = DateTime.now();
    
    for (int i = 0; i < months; i++) {
      final date = DateTime(now.year, now.month - i, 1);
      final data = getMonthlyData(date);
      if (data != null) {
        result.add(data);
      }
    }
    
    return result.reversed.toList();
  }

  // Stats for AI
  Map<String, dynamic> getStatsForAI() {
    final current = currentMonthData;
    final lastMonth = getMonthlyData(DateTime.now().subtract(const Duration(days: 30)));
    
    return {
      'currentMonth': current.toJson(),
      'lastMonth': lastMonth?.toJson(),
      'avgMonthlySpending': _calculateAvgSpending(),
      'topCategories': current.spendingByCategory.entries
        .toList()
        ..sort((a, b) => b.value.compareTo(a.value))
        ..take(5)
        .map((e) => {'category': e.key, 'amount': e.value})
        .toList(),
      'subscriptionCount': current.subscriptions.length,
      'unusedSubscriptions': current.subscriptions.where((s) => s.isUnused).length,
    };
  }

  double _calculateAvgSpending() {
    final months = getLastNMonths(6);
    if (months.isEmpty) return 0;
    return months.fold(0.0, (sum, m) => sum + m.monthlyExpenses) / months.length;
  }

  // Helper
  String _monthKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}';
  }

  Future<void> clearAll() async {
    await box.clear();
  }
}
