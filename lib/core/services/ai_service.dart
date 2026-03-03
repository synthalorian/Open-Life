import 'package:flutter_riverpod/flutter_riverpod.dart';

/// AI Service for Open Life
/// 
/// This service handles all AI interactions across the app.
/// Currently supports OpenAI API but designed to be provider-agnostic.
class AIService {
  final String apiKey;
  final String model;
  final double temperature;
  final int maxTokens;

  AIService({
    required this.apiKey,
    this.model = 'gpt-4-turbo-preview',
    this.temperature = 0.7,
    this.maxTokens = 4096,
  });

  /// Send a message to the AI with context from all three pillars
  Future<String> sendMessage({
    required String message,
    required String systemPrompt,
    Map<String, dynamic>? fitnessContext,
    Map<String, dynamic>? financeContext,
    Map<String, dynamic>? assuranceContext,
  }) async {
    // Build context string
    final contextBuffer = StringBuffer();
    
    if (fitnessContext != null) {
      contextBuffer.writeln('\n## Fitness Context:');
      fitnessContext.forEach((key, value) {
        contextBuffer.writeln('- $key: $value');
      });
    }
    
    if (financeContext != null) {
      contextBuffer.writeln('\n## Finance Context:');
      financeContext.forEach((key, value) {
        contextBuffer.writeln('- $key: $value');
      });
    }
    
    if (assuranceContext != null) {
      contextBuffer.writeln('\n## Health Context:');
      assuranceContext.forEach((key, value) {
        contextBuffer.writeln('- $key: $value');
      });
    }

    final fullPrompt = '''
$systemPrompt

# User Context
$contextBuffer

# User Message
$message
''';

    // TODO: Implement actual API call
    // For now, return a placeholder
    return _getMockResponse(message);
  }

  String _getMockResponse(String query) {
    if (query.toLowerCase().contains('health')) {
      return 'Based on your data, your health is looking good! Your blood pressure is in a healthy range and you\'re staying active.';
    }
    if (query.toLowerCase().contains('budget') || query.toLowerCase().contains('money')) {
      return 'You\'re doing well with your finances this month. You\'ve saved 34% of your income, which is above the recommended 20%.';
    }
    if (query.toLowerCase().contains('workout') || query.toLowerCase().contains('exercise')) {
      return 'I recommend adding a 20-minute HIIT session to your routine this week. Based on your current activity level, this will help you reach your goals faster.';
    }
    return 'I\'m here to help you with your fitness, finance, and health goals. Ask me anything!';
  }

  /// Generate insights based on user data
  Future<List<AIInsight>> generateInsights({
    required Map<String, dynamic> fitnessData,
    required Map<String, dynamic> financeData,
    required Map<String, dynamic> assuranceData,
  }) async {
    // TODO: Implement AI-powered insight generation
    return [
      AIInsight(
        title: 'Increase Your Savings',
        description: 'You could save an extra \$150/month by optimizing your subscriptions.',
        category: InsightCategory.finance,
        priority: InsightPriority.medium,
      ),
      AIInsight(
        title: 'Add Cardio Session',
        description: 'A 15-minute cardio session would help you hit your weekly step goal.',
        category: InsightCategory.fitness,
        priority: InsightPriority.high,
      ),
      AIInsight(
        title: 'Schedule Checkup',
        description: 'Your annual physical is due in 2 weeks. Book now to avoid delays.',
        category: InsightCategory.health,
        priority: InsightPriority.high,
      ),
    ];
  }
}

class AIInsight {
  final String title;
  final String description;
  final InsightCategory category;
  final InsightPriority priority;
  final DateTime createdAt;

  const AIInsight({
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? const Duration(seconds: 0) as DateTime;
}

enum InsightCategory {
  fitness,
  finance,
  health,
  holistic,
}

enum InsightPriority {
  low,
  medium,
  high,
}

/// Provider for AI Service
final aiServiceProvider = Provider<AIService>((ref) {
  // TODO: Load API key from secure storage
  return AIService(
    apiKey: const String.fromEnvironment('OPENAI_API_KEY', defaultValue: ''),
  );
});
