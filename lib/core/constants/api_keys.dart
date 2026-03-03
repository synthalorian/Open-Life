/// API Keys Configuration
/// 
/// NEVER commit this file with real keys to version control!
/// Add this file to .gitignore
class ApiKeys {
  ApiKeys._();

  // OpenAI API Key
  // Get yours at: https://platform.openai.com/api-keys
  static const String openAIApiKey = String.fromEnvironment(
    'OPENAI_API_KEY',
    defaultValue: '',
  );

  // Optional: Use a different AI provider
  // static const String anthropicApiKey = '';
  // static const String googleGeminiApiKey = '';

  static bool get hasOpenAIKey => openAIApiKey.isNotEmpty;
}
