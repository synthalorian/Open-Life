import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';


@HiveType(typeId: 20)
class FinanceData extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  // Account summary
  @HiveField(2)
  double totalBalance;

  @HiveField(3)
  double monthlyIncome;

  @HiveField(4)
  double monthlyExpenses;

  // Daily tracking
  @HiveField(5)
  List<Transaction> transactions;

  @HiveField(6)
  List<Budget> budgets;

  @HiveField(7)
  List<SavingsGoal> savingsGoals;

  @HiveField(8)
  List<Subscription> subscriptions;

  // Health correlation data (for AI insights)
  @HiveField(9)
  double? stressRelatedSpending; // Estimated amount spent due to stress

  @HiveField(10)
  List<String> impulsePurchaseCategories; // Categories where user overspends

  @HiveField(11)
  DateTime createdAt;

  @HiveField(12)
  DateTime updatedAt;

  FinanceData({
    String? id,
    DateTime? date,
    this.totalBalance = 0,
    this.monthlyIncome = 0,
    this.monthlyExpenses = 0,
    this.transactions = const [],
    this.budgets = const [],
    this.savingsGoals = const [],
    this.subscriptions = const [],
    this.stressRelatedSpending,
    this.impulsePurchaseCategories = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  double get netCashflow => monthlyIncome - monthlyExpenses;
  double get savingsRate => monthlyIncome > 0 ? netCashflow / monthlyIncome : 0;
  double get dailySpending => transactions.where((t) => t.isExpense).fold(0.0, (sum, t) => sum + t.amount);
  int get transactionCount => transactions.length;
  double get totalSubscriptions => subscriptions.fold(0, (sum, s) => sum + s.monthlyCost);
  bool get isOverBudget => monthlyExpenses > monthlyIncome;

  // For AI analysis
  Map<String, double> get spendingByCategory {
    final Map<String, double> map = {};
    for (final t in transactions.where((t) => t.isExpense)) {
      map[t.category] = (map[t.category] ?? 0) + t.amount;
    }
    return map;
  }

  double get totalDebt => subscriptions.where((s) => s.isDebt).fold(0.0, (sum, s) => sum + (s.balance ?? 0));

  FinanceData copyWith({
    String? id,
    DateTime? date,
    double? totalBalance,
    double? monthlyIncome,
    double? monthlyExpenses,
    List<Transaction>? transactions,
    List<Budget>? budgets,
    List<SavingsGoal>? savingsGoals,
    List<Subscription>? subscriptions,
    double? stressRelatedSpending,
    List<String>? impulsePurchaseCategories,
  }) {
    return FinanceData(
      id: id ?? this.id,
      date: date ?? this.date,
      totalBalance: totalBalance ?? this.totalBalance,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      monthlyExpenses: monthlyExpenses ?? this.monthlyExpenses,
      transactions: transactions ?? this.transactions,
      budgets: budgets ?? this.budgets,
      savingsGoals: savingsGoals ?? this.savingsGoals,
      subscriptions: subscriptions ?? this.subscriptions,
      stressRelatedSpending: stressRelatedSpending ?? this.stressRelatedSpending,
      impulsePurchaseCategories: impulsePurchaseCategories ?? this.impulsePurchaseCategories,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'totalBalance': totalBalance,
    'monthlyIncome': monthlyIncome,
    'monthlyExpenses': monthlyExpenses,
    'netCashflow': netCashflow,
    'savingsRate': savingsRate,
    'transactionCount': transactionCount,
    'totalSubscriptions': totalSubscriptions,
    'isOverBudget': isOverBudget,
    'topSpendingCategory': spendingByCategory.entries.isNotEmpty 
      ? spendingByCategory.entries.reduce((a, b) => a.value > b.value ? a : b).key 
      : null,
  };
}

@HiveType(typeId: 21)
class Transaction extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String category;

  @HiveField(3)
  double amount;

  @HiveField(4)
  bool isExpense;

  @HiveField(5)
  DateTime date;

  @HiveField(6)
  String? merchant;

  @HiveField(7)
  String? notes;

  @HiveField(8)
  String? aiCategorization; // AI's confidence in category

  @HiveField(9)
  bool isRecurring;

  @HiveField(10)
  bool isImpulse; // Flagged by AI as impulse purchase

  @HiveField(11)
  int? stressLevel; // 1-10, if user was stressed when purchasing

  Transaction({
    String? id,
    required this.name,
    required this.category,
    required this.amount,
    required this.isExpense,
    DateTime? date,
    this.merchant,
    this.notes,
    this.aiCategorization,
    this.isRecurring = false,
    this.isImpulse = false,
    this.stressLevel,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now();

  String get formattedAmount => isExpense 
    ? '-\$${amount.toStringAsFixed(2)}' 
    : '+\$${amount.toStringAsFixed(2)}';

  Map<String, dynamic> toJson() => {
    'name': name,
    'category': category,
    'amount': amount,
    'isExpense': isExpense,
    'isImpulse': isImpulse,
    'stressLevel': stressLevel,
  };
}

@HiveType(typeId: 22)
class Budget extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String category;

  @HiveField(3)
  double limit;

  @HiveField(4)
  double spent;

  @HiveField(5)
  String? aiRecommendation; // AI suggestion for budget adjustment

  @HiveField(6)
  bool isAIRecommended; // Whether AI created this budget

  Budget({
    String? id,
    required this.name,
    required this.category,
    required this.limit,
    this.spent = 0,
    this.aiRecommendation,
    this.isAIRecommended = false,
  }) : id = id ?? const Uuid().v4();

  double get percentage => limit > 0 ? spent / limit : 0;
  double get remaining => limit - spent;
  bool get isOverBudget => spent > limit;
  bool get isNearLimit => percentage >= 0.8;

  Map<String, dynamic> toJson() => {
    'name': name,
    'limit': limit,
    'spent': spent,
    'percentage': percentage,
    'remaining': remaining,
    'isOverBudget': isOverBudget,
  };
}

@HiveType(typeId: 23)
class SavingsGoal extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double target;

  @HiveField(3)
  double current;

  @HiveField(4)
  DateTime? deadline;

  @HiveField(5)
  String? aiTimeline; // AI-generated realistic timeline

  @HiveField(6)
  double? aiSuggestedMonthlyContribution;

  @HiveField(7)
  bool isHealthRelated; // Emergency fund, health expenses, etc.

  SavingsGoal({
    String? id,
    required this.name,
    required this.target,
    this.current = 0,
    this.deadline,
    this.aiTimeline,
    this.aiSuggestedMonthlyContribution,
    this.isHealthRelated = false,
  }) : id = id ?? const Uuid().v4();

  double get progress => target > 0 ? current / target : 0;
  double get remaining => target - current;
  bool get isCompleted => current >= target;

  // Days until deadline
  int? get daysRemaining => deadline?.difference(DateTime.now()).inDays;

  Map<String, dynamic> toJson() => {
    'name': name,
    'target': target,
    'current': current,
    'progress': progress,
    'isCompleted': isCompleted,
    'daysRemaining': daysRemaining,
  };
}

@HiveType(typeId: 24)
class Subscription extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double monthlyCost;

  @HiveField(3)
  String category;

  @HiveField(4)
  DateTime? nextBillingDate;

  @HiveField(5)
  bool isUnused; // Flagged by AI as unused

  @HiveField(6)
  String? aiAlternative; // AI-suggested cheaper alternative

  @HiveField(7)
  double? annualSavings; // If user switched to AI alternative

  @HiveField(8)
  bool isDebt; // Credit cards, loans, etc.

  @HiveField(9)
  double? balance; // For debt subscriptions

  Subscription({
    String? id,
    required this.name,
    required this.monthlyCost,
    required this.category,
    this.nextBillingDate,
    this.isUnused = false,
    this.aiAlternative,
    this.annualSavings,
    this.isDebt = false,
    this.balance,
  }) : id = id ?? const Uuid().v4();

  double get annualCost => monthlyCost * 12;

  Map<String, dynamic> toJson() => {
    'name': name,
    'monthlyCost': monthlyCost,
    'annualCost': annualCost,
    'isUnused': isUnused,
    'isDebt': isDebt,
  };
}
