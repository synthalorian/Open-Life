import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? email;

  @HiveField(2)
  DateTime? dateOfBirth;

  @HiveField(3)
  String? profileImagePath;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;

  UserProfile({
    required this.name,
    this.email,
    this.dateOfBirth,
    this.profileImagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  UserProfile copyWith({
    String? name,
    String? email,
    DateTime? dateOfBirth,
    String? profileImagePath,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}

@HiveType(typeId: 1)
class UserPreferences extends HiveObject {
  @HiveField(0)
  bool darkModeEnabled;

  @HiveField(1)
  bool notificationsEnabled;

  @HiveField(2)
  bool aiInsightsEnabled;

  @HiveField(3)
  String? openAIApiKey;

  @HiveField(4)
  String preferredAIModel;

  @HiveField(5)
  int dailyStepGoal;

  @HiveField(6)
  int dailyCalorieGoal;

  @HiveField(7)
  double monthlyBudgetLimit;

  UserPreferences({
    this.darkModeEnabled = true,
    this.notificationsEnabled = true,
    this.aiInsightsEnabled = true,
    this.openAIApiKey,
    this.preferredAIModel = 'gpt-4-turbo-preview',
    this.dailyStepGoal = 10000,
    this.dailyCalorieGoal = 2000,
    this.monthlyBudgetLimit = 3000,
  });

  UserPreferences copyWith({
    bool? darkModeEnabled,
    bool? notificationsEnabled,
    bool? aiInsightsEnabled,
    String? openAIApiKey,
    String? preferredAIModel,
    int? dailyStepGoal,
    int? dailyCalorieGoal,
    double? monthlyBudgetLimit,
  }) {
    return UserPreferences(
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      aiInsightsEnabled: aiInsightsEnabled ?? this.aiInsightsEnabled,
      openAIApiKey: openAIApiKey ?? this.openAIApiKey,
      preferredAIModel: preferredAIModel ?? this.preferredAIModel,
      dailyStepGoal: dailyStepGoal ?? this.dailyStepGoal,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      monthlyBudgetLimit: monthlyBudgetLimit ?? this.monthlyBudgetLimit,
    );
  }
}
