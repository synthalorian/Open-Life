import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/neon_card.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../providers/finance_provider.dart';
import '../../../shared/models/finance_data.dart';

class FinancePage extends ConsumerStatefulWidget {
  const FinancePage({super.key});

  @override
  ConsumerState<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends ConsumerState<FinancePage> with SingleTickerProviderStateMixin {
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
    final financeState = ref.watch(financeProvider);

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
                      AppColors.financePrimary.withOpacity(0.3),
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
                          shaderCallback: (bounds) => AppColors.financeGradient.createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: Text(
                            'Finance',
                            style: AppTextStyles.h1.copyWith(color: Colors.white),
                          ),
                        ).animate().fadeIn(),
                        const SizedBox(height: 8),
                        Text(
                          'AI-powered money management',
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
              indicatorColor: AppColors.financePrimary,
              labelColor: AppColors.financePrimary,
              unselectedLabelColor: AppColors.textMuted,
              tabs: [
                Tab(icon: Icon(PhosphorIcons.chartPie())),
                Tab(icon: Icon(PhosphorIcons.wallet())),
                Tab(icon: Icon(PhosphorIcons.target())),
                Tab(icon: Icon(PhosphorIcons.sparkle())),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(financeState),
            _buildBudgetTab(),
            _buildGoalsTab(),
            _buildAIAdvisorTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab(FinanceState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance Card
          NeonCard(
            gradient: AppColors.financeGradient,
            glowColor: AppColors.financePrimary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Balance', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70)),
                const SizedBox(height: 8),
                Text(
                  '\$${state.totalBalance.toStringAsFixed(2)}',
                  style: AppTextStyles.statLarge.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Income', style: AppTextStyles.caption.copyWith(color: Colors.white60)),
                          Text(
                            '+\$${state.monthlyIncome.toStringAsFixed(2)}',
                            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.success),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Expenses', style: AppTextStyles.caption.copyWith(color: Colors.white60)),
                          Text(
                            '-\$${state.monthlyExpenses.toStringAsFixed(2)}',
                            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.error),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.1),

          const SizedBox(height: 24),

          // Spending Chart
          Text('Spending by Category', style: AppTextStyles.h4).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 16),
          NeonCard(
            glowColor: AppColors.financePrimary,
            child: SizedBox(
              height: 200,
              child: Builder(
                builder: (context) {
                  final categories = state.topSpendingCategories;
                  final total = categories.fold(0.0, (sum, e) => sum + e.value);
                  final colors = [
                    AppColors.sunsetOrange,
                    AppColors.cyan,
                    AppColors.neonPink,
                    AppColors.financePrimary,
                    AppColors.electricPurple,
                  ];
                  return PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: categories.asMap().entries.map((entry) {
                        final cat = entry.value;
                        final percentage = total > 0 ? (cat.value / total * 100) : 0;
                        return PieChartSectionData(
                          value: cat.value,
                          title: '${percentage.toInt()}%',
                          color: colors[entry.key % colors.length],
                          radius: 60,
                          titleStyle: AppTextStyles.caption.copyWith(color: Colors.white),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

          const SizedBox(height: 24),

          // Recent Transactions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Transactions', style: AppTextStyles.h4),
              TextButton(
                onPressed: () {},
                child: Text('See All', style: AppTextStyles.label),
              ),
            ],
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 12),
          ...state.recentTransactions.map((tx) => _buildTransactionTile(tx)),

          // AI Insight
          const SizedBox(height: 24),
          _buildAIInsight(state.aiInsight ?? '').animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildBudgetTab() {
    final financeState = ref.watch(financeProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Monthly Budgets', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          ...financeState.budgets.map((budget) => _buildBudgetCard(budget)),
          const SizedBox(height: 24),
          GradientButton(
            text: 'Add Budget',
            icon: PhosphorIcons.plus(),
            gradient: AppColors.financeGradient,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsTab() {
    final financeState = ref.watch(financeProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Savings Goals', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          ...financeState.savingsGoals.map((goal) => _buildGoalCard(goal)),
          const SizedBox(height: 24),
          GradientButton(
            text: 'Create Goal',
            icon: PhosphorIcons.plus(),
            gradient: AppColors.financeGradient,
          ),
        ],
      ),
    );
  }

  Widget _buildAIAdvisorTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NeonCard(
            gradient: LinearGradient(
              colors: [
                AppColors.financePrimary.withOpacity(0.2),
                AppColors.sunsetOrange.withOpacity(0.2),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: AppColors.financeGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(PhosphorIcons.brain(), size: 32, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text('AI Financial Advisor', style: AppTextStyles.h3),
                const SizedBox(height: 8),
                Text(
                  'Get personalized advice on budgeting, saving, and reaching your financial goals',
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                GradientButton(
                  text: 'Start Chat',
                  icon: PhosphorIcons.chatCircle(),
                  gradient: AppColors.financeGradient,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Quick Questions', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          _buildQuickQuestion('How can I save more each month?'),
          _buildQuickQuestion('Should I pay off debt or save first?'),
          _buildQuickQuestion('Am I on track for retirement?'),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(Transaction tx) {
    return NeonCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tx.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(tx.icon, color: tx.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.name, style: AppTextStyles.bodyMedium),
                Text(tx.category, style: AppTextStyles.caption),
              ],
            ),
          ),
          Text(
            tx.isExpense ? '-\$${tx.amount.toStringAsFixed(2)}' : '+\$${tx.amount.toStringAsFixed(2)}',
            style: AppTextStyles.bodyLarge.copyWith(
              color: tx.isExpense ? AppColors.error : AppColors.success,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetCard(Budget budget) {
    final progress = budget.spent / budget.limit;
    return NeonCard(
      margin: const EdgeInsets.only(bottom: 12),
      glowColor: budget.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(budget.icon, color: budget.color),
                  const SizedBox(width: 8),
                  Text(budget.name, style: AppTextStyles.bodyLarge),
                ],
              ),
              Text(
                '\$${budget.spent.toStringAsFixed(0)} / \$${budget.limit.toStringAsFixed(0)}',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
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
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [budget.color, budget.color.withOpacity(0.6)]),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(color: budget.color.withOpacity(0.5), blurRadius: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (progress > 0.8) ...[
            const SizedBox(height: 8),
            Text(
              progress >= 1 ? '⚠️ Budget exceeded!' : '⚠️ ${((1 - progress) * 100).toInt()}% remaining',
              style: AppTextStyles.caption.copyWith(color: AppColors.warning),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGoalCard(SavingsGoal goal) {
    final progress = goal.current / goal.target;
    return NeonCard(
      margin: const EdgeInsets.only(bottom: 12),
      glowColor: AppColors.financePrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: AppColors.financeGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(PhosphorIcons.flag(), color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal.name, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                    Text('Target: ${goal.deadline}', style: AppTextStyles.caption),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${goal.current.toStringAsFixed(0)}',
                    style: AppTextStyles.h4.copyWith(color: AppColors.financePrimary),
                  ),
                  Text(
                    'of \$${goal.target.toStringAsFixed(0)}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
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
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: AppColors.financeGradient,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(color: AppColors.financePrimary.withOpacity(0.5), blurRadius: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${(progress * 100).toInt()}% complete',
            style: AppTextStyles.caption.copyWith(color: AppColors.financePrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildAIInsight(String insight) {
    return NeonCard(
      gradient: LinearGradient(
        colors: [
          AppColors.financePrimary.withOpacity(0.2),
          AppColors.sunsetOrange.withOpacity(0.2),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.financePrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(PhosphorIcons.sparkle(), color: AppColors.financePrimary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Insight', style: AppTextStyles.h5.copyWith(color: AppColors.financePrimary)),
                const SizedBox(height: 4),
                Text(insight, style: AppTextStyles.bodyMedium),
              ],
            ),
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
