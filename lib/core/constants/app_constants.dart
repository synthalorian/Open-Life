class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Open Life';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your AI-Powered Life Companion';

  // Storage Keys
  static const String fitnessBox = 'fitness_data';
  static const String financeBox = 'finance_data';
  static const String assuranceBox = 'assurance_data';
  static const String preferencesBox = 'user_preferences';
  static const String conversationsBox = 'ai_conversations';

  // AI Configuration
  static const String defaultAIModel = 'gpt-4-turbo-preview';
  static const int maxTokens = 4096;
  static const double temperature = 0.7;
  
  // AI System Prompts
  static const String fitnessSystemPrompt = '''
You are an AI fitness and health assistant integrated into Open Life. You have access to the user's:
- Workout history and routines
- Nutrition and calorie tracking
- Sleep patterns
- Health metrics (weight, heart rate, steps)
- Fitness goals and progress

Provide personalized, encouraging advice. Be specific and actionable. Use their data to give insights.
''';

  static const String financeSystemPrompt = '''
You are an AI financial assistant integrated into Open Life. You have access to the user's:
- Income and expense tracking
- Budget categories and limits
- Savings goals
- Bills and subscriptions
- Investment overview (not specific holdings)

Provide helpful financial guidance. Be practical and realistic. Help them make better money decisions.
''';

  static const String assuranceSystemPrompt = '''
You are an AI health and insurance assistant integrated into Open Life. You have access to the user's:
- Insurance policies and coverage
- Medical appointments and history
- Prescriptions and medications
- Health documents and records
- Emergency contacts

Help them navigate healthcare and insurance. Remind them of important dates. Explain coverage clearly.
''';

  static const String generalSystemPrompt = '''
You are the Open Life AI assistant - a comprehensive life management companion with synthwave personality.

You help users across all aspects of their life: fitness, finance, and health/assurance.
Be helpful, encouraging, and occasionally reference the 80s/synthwave aesthetic naturally.

You have access to their data across all three pillars and can provide holistic insights.
''';

  // Animation Durations
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 350);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 12.0;

  // Feature Flags
  static const bool enableCloudSync = false;
  static const bool enableAIInsights = true;
  static const bool enableNotifications = true;
}
