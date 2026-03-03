import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../fitness/providers/fitness_provider.dart';
import '../../finance/providers/finance_provider.dart';
import '../../assurance/providers/assurance_provider.dart';

class MessageContext {
  final String label;
  final IconData icon;
  final Color color;

  const MessageContext({
    required this.label,
    required this.icon,
    required this.color,
  });
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final List<MessageContext>? context;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.context,
  });
}

class AIChatState {
  final List<ChatMessage> messages;
  final bool isTyping;
  final String? error;

  const AIChatState({
    this.messages = const [],
    this.isTyping = false,
    this.error,
  });

  AIChatState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
    String? error,
  }) {
    return AIChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      error: error ?? this.error,
    );
  }
}

class AIChatNotifier extends StateNotifier<AIChatState> {
  final Ref ref;

  AIChatNotifier(this.ref) : super(const AIChatState());

  Future<void> sendMessage(String text) async {
    // Add user message
    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
    
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isTyping: true,
    );

    // Simulate AI processing
    await Future.delayed(const Duration(seconds: 2));

    // Get context from all data sources
    final fitness = ref.read(fitnessProvider);
    final finance = ref.read(financeProvider);
    final assurance = ref.read(assuranceProvider);

    // Generate AI response based on context
    final response = _generateResponse(text, fitness, finance, assurance);

    // Add AI response
    final aiMessage = ChatMessage(
      text: response.text,
      isUser: false,
      timestamp: DateTime.now(),
      context: response.context,
    );

    state = state.copyWith(
      messages: [...state.messages, aiMessage],
      isTyping: false,
    );
  }

  _AIResponse _generateResponse(String query, FitnessState fitness, FinanceState finance, AssuranceState assurance) {
    final lowerQuery = query.toLowerCase();
    
    // Holistic health analysis
    if (lowerQuery.contains('overall health') || lowerQuery.contains('health summary')) {
      return _AIResponse(
        text: '''Here's your health overview:

**Fitness:** You've taken ${fitness.steps.toLocaleString()} steps today (${(fitness.steps / fitness.stepsGoal * 100).toInt()}% of goal). Active for ${fitness.activeMinutes} minutes.

**Vitals:** Blood pressure is ${assurance.bloodPressureSystolic}/${assurance.bloodPressureDiastolic} mmHg (healthy range). Weight: ${assurance.weight} lbs.

**Upcoming:** You have an appointment with ${assurance.upcomingAppointments.first.doctorName} in ${assurance.upcomingAppointments.first.daysUntil} days.

**Recommendation:** ${fitness.aiInsight}''',
        context: [
          const MessageContext(label: 'Fitness', icon: PhosphorIcons.barbell, color: AppColors.fitnessPrimary),
          const MessageContext(label: 'Health', icon: PhosphorIcons.heart, color: AppColors.assurancePrimary),
        ],
      );
    }

    // Spending analysis
    if (lowerQuery.contains('spending') || lowerQuery.contains('budget') || lowerQuery.contains('money')) {
      final topCategory = finance.spendingCategories.first;
      return _AIResponse(
        text: '''Here's your financial snapshot:

**Balance:** \$${finance.totalBalance.toStringAsFixed(2)}

**This Month:**
- Income: \$${finance.monthlyIncome.toStringAsFixed(2)}
- Expenses: \$${finance.monthlyExpenses.toStringAsFixed(2)}
- Saved: \$${(finance.monthlyIncome - finance.monthlyExpenses).toStringAsFixed(2)}

**Top Spending:** ${topCategory.name} at \$${topCategory.amount.toStringAsFixed(2)} (${topCategory.percentage.toInt()}% of expenses)

**Insight:** ${finance.aiInsight}''',
        context: [
          const MessageContext(label: 'Finance', icon: PhosphorIcons.wallet, color: AppColors.financePrimary),
        ],
      );
    }

    // Workout plan
    if (lowerQuery.contains('workout') || lowerQuery.contains('exercise') || lowerQuery.contains('fitness')) {
      return _AIResponse(
        text: '''Based on your current activity level and goals, here's a personalized workout plan:

**Today's Focus: Active Recovery**
- 10 min light stretching
- 15 min walk (you need ${fitness.stepsGoal - fitness.steps} more steps)
- 5 min foam rolling

**This Week:**
- Monday: Upper body strength (30 min)
- Wednesday: HIIT cardio (20 min)
- Friday: Lower body strength (30 min)
- Weekend: Long walk or hike (45+ min)

**Tip:** ${fitness.aiInsight}''',
        context: [
          const MessageContext(label: 'Fitness', icon: PhosphorIcons.barbell, color: AppColors.fitnessPrimary),
        ],
      );
    }

    // Weekly summary
    if (lowerQuery.contains('weekly') || lowerQuery.contains('summary') || lowerQuery.contains('overview')) {
      return _AIResponse(
        text: '''Here's your weekly life summary:

**💪 Fitness**
- Average steps: ${(fitness.weeklySteps.reduce((a, b) => a + b) / fitness.weeklySteps.length).toInt()}/day
- Active minutes: ${fitness.activeMinutes * 7} total
- Trend: 23% more active than last week!

**💰 Finance**
- Spent: \$${finance.monthlyExpenses.toStringAsFixed(2)}
- Saved: \$${(finance.monthlyIncome - finance.monthlyExpenses).toStringAsFixed(2)}
- Savings rate: ${((finance.monthlyIncome - finance.monthlyExpenses) / finance.monthlyIncome * 100).toInt()}%

**🏥 Health**
- BP: ${assurance.bloodPressureSystolic}/${assurance.bloodPressureDiastolic} (normal)
- Appointments: ${assurance.upcomingAppointments.length} upcoming
- Medications: ${assurance.medications.length} active

**AI Recommendation:** You're doing great! Focus on maintaining your step count and consider increasing your savings rate by 5%.''',
        context: [
          const MessageContext(label: 'Fitness', icon: PhosphorIcons.barbell, color: AppColors.fitnessPrimary),
          const MessageContext(label: 'Finance', icon: PhosphorIcons.wallet, color: AppColors.financePrimary),
          const MessageContext(label: 'Health', icon: PhosphorIcons.heart, color: AppColors.assurancePrimary),
        ],
      );
    }

    // Default response
    return _AIResponse(
      text: '''I can help you with:

• **Fitness** - Workouts, nutrition, activity tracking
• **Finance** - Budgeting, spending analysis, savings goals
• **Health** - Appointments, insurance, medications
• **Insights** - Cross-domain recommendations

Ask me anything about your life, and I'll use all your data to give you personalized advice!''',
      context: null,
    );
  }

  void clearHistory() {
    state = const AIChatState();
  }
}

class _AIResponse {
  final String text;
  final List<MessageContext>? context;

  const _AIResponse({required this.text, this.context});
}

final aiChatProvider = StateNotifierProvider<AIChatNotifier, AIChatState>((ref) {
  return AIChatNotifier(ref);
});

extension on int {
  String toLocaleString() => toString();
}
