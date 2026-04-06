import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';


@HiveType(typeId: 10)
class FitnessData extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  // Steps
  @HiveField(2)
  int steps;

  @HiveField(3)
  int stepsGoal;

  // Activity
  @HiveField(4)
  int activeMinutes;

  @HiveField(5)
  int caloriesBurned;

  // Heart rate
  @HiveField(6)
  int? restingHeartRate;

  @HiveField(7)
  List<int> heartRateSamples; // Hourly samples

  // Sleep
  @HiveField(8)
  SleepData? sleep;

  // Workouts
  @HiveField(9)
  List<Workout> workouts;

  // Nutrition
  @HiveField(10)
  List<Meal> meals;

  @HiveField(11)
  int calorieGoal;

  // Metrics
  @HiveField(12)
  double? weight;

  @HiveField(13)
  double? bodyFatPercentage;

  // Mood/Energy (for AI correlation analysis)
  @HiveField(14)
  int? moodRating; // 1-10

  @HiveField(15)
  int? energyLevel; // 1-10

  // Stress (affects finance and health)
  @HiveField(16)
  int? stressLevel; // 1-10

  @HiveField(17)
  DateTime createdAt;

  @HiveField(18)
  DateTime updatedAt;

  FitnessData({
    String? id,
    DateTime? date,
    this.steps = 0,
    this.stepsGoal = 10000,
    this.activeMinutes = 0,
    this.caloriesBurned = 0,
    this.restingHeartRate,
    this.heartRateSamples = const [],
    this.sleep,
    this.workouts = const [],
    this.meals = const [],
    this.calorieGoal = 2000,
    this.weight,
    this.bodyFatPercentage,
    this.moodRating,
    this.energyLevel,
    this.stressLevel,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  double get stepsPercentage => stepsGoal > 0 ? steps / stepsGoal : 0;
  int get netCalories => meals.fold(0, (sum, m) => sum + m.calories) - caloriesBurned;
  int get consumedCalories => meals.fold(0, (sum, m) => sum + m.calories);
  int get caloriesRemaining => calorieGoal - consumedCalories;
  int get workoutCount => workouts.length;
  int get totalWorkoutMinutes => workouts.fold(0, (sum, w) => sum + w.durationMinutes);
  bool get hasSleepData => sleep != null;
  bool get hitStepsGoal => steps >= stepsGoal;
  bool get hitCalorieGoal => consumedCalories <= calorieGoal;

  FitnessData copyWith({
    String? id,
    DateTime? date,
    int? steps,
    int? stepsGoal,
    int? activeMinutes,
    int? caloriesBurned,
    int? restingHeartRate,
    List<int>? heartRateSamples,
    SleepData? sleep,
    List<Workout>? workouts,
    List<Meal>? meals,
    int? calorieGoal,
    double? weight,
    double? bodyFatPercentage,
    int? moodRating,
    int? energyLevel,
    int? stressLevel,
  }) {
    return FitnessData(
      id: id ?? this.id,
      date: date ?? this.date,
      steps: steps ?? this.steps,
      stepsGoal: stepsGoal ?? this.stepsGoal,
      activeMinutes: activeMinutes ?? this.activeMinutes,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      restingHeartRate: restingHeartRate ?? this.restingHeartRate,
      heartRateSamples: heartRateSamples ?? this.heartRateSamples,
      sleep: sleep ?? this.sleep,
      workouts: workouts ?? this.workouts,
      meals: meals ?? this.meals,
      calorieGoal: calorieGoal ?? this.calorieGoal,
      weight: weight ?? this.weight,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      moodRating: moodRating ?? this.moodRating,
      energyLevel: energyLevel ?? this.energyLevel,
      stressLevel: stressLevel ?? this.stressLevel,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'steps': steps,
    'stepsGoal': stepsGoal,
    'activeMinutes': activeMinutes,
    'caloriesBurned': caloriesBurned,
    'consumedCalories': consumedCalories,
    'netCalories': netCalories,
    'weight': weight,
    'moodRating': moodRating,
    'energyLevel': energyLevel,
    'stressLevel': stressLevel,
    'workoutCount': workoutCount,
    'hitStepsGoal': hitStepsGoal,
  };
}

@HiveType(typeId: 11)
class SleepData extends HiveObject {
  @HiveField(0)
  DateTime startTime;

  @HiveField(1)
  DateTime endTime;

  @HiveField(2)
  int durationMinutes;

  @HiveField(3)
  int deepSleepMinutes;

  @HiveField(4)
  int remSleepMinutes;

  @HiveField(5)
  int lightSleepMinutes;

  @HiveField(6)
  int awakeMinutes;

  @HiveField(7)
  int sleepQuality; // 1-10

  SleepData({
    required this.startTime,
    required this.endTime,
    this.deepSleepMinutes = 0,
    this.remSleepMinutes = 0,
    this.lightSleepMinutes = 0,
    this.awakeMinutes = 0,
    this.sleepQuality = 5,
  }) : durationMinutes = endTime.difference(startTime).inMinutes;

  double get sleepEfficiency => durationMinutes > 0 
    ? (deepSleepMinutes + remSleepMinutes) / durationMinutes * 100 
    : 0;
  
  double get hours => durationMinutes / 60;
  String get formattedDuration => '${hours.toStringAsFixed(1)}h';

  Map<String, dynamic> toJson() => {
    'durationHours': hours.toStringAsFixed(1),
    'quality': sleepQuality,
    'efficiency': sleepEfficiency.toStringAsFixed(0),
    'deepSleepPercent': (deepSleepMinutes / durationMinutes * 100).toStringAsFixed(0),
  };
}

@HiveType(typeId: 12)
class Workout extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  WorkoutType type;

  @HiveField(3)
  int durationMinutes;

  @HiveField(4)
  int caloriesBurned;

  @HiveField(5)
  int? averageHeartRate;

  @HiveField(6)
  int? maxHeartRate;

  @HiveField(7)
  DateTime startTime;

  @HiveField(8)
  String? notes;

  @HiveField(9)
  List<Exercise> exercises;

  @HiveField(10)
  int intensity; // 1-10

  Workout({
    String? id,
    required this.name,
    required this.type,
    required this.durationMinutes,
    this.caloriesBurned = 0,
    this.averageHeartRate,
    this.maxHeartRate,
    DateTime? startTime,
    this.notes,
    this.exercises = const [],
    this.intensity = 5,
  })  : id = id ?? const Uuid().v4(),
        startTime = startTime ?? DateTime.now();

  String get formattedDuration => '${durationMinutes}m';
  String get formattedCalories => '${caloriesBurned}cal';

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type.name,
    'duration': durationMinutes,
    'calories': caloriesBurned,
    'intensity': intensity,
  };
}

@HiveType(typeId: 13)
class Exercise extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int sets;

  @HiveField(2)
  int reps;

  @HiveField(3)
  double? weight; // in lbs

  @HiveField(4)
  int? durationSeconds;

  @HiveField(5)
  String? notes;

  Exercise({
    required this.name,
    this.sets = 0,
    this.reps = 0,
    this.weight,
    this.durationSeconds,
    this.notes,
  });
}

@HiveType(typeId: 14)
class Meal extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  MealType type; // breakfast, lunch, dinner, snack

  @HiveField(3)
  DateTime time;

  @HiveField(4)
  int calories;

  @HiveField(5)
  double protein; // grams

  @HiveField(6)
  double carbs; // grams

  @HiveField(7)
  double fat; // grams

  @HiveField(8)
  String? notes;

  @HiveField(9)
  String? aiAnalysis; // AI-generated nutrition insights

  Meal({
    String? id,
    required this.name,
    required this.type,
    DateTime? time,
    this.calories = 0,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.notes,
    this.aiAnalysis,
  })  : id = id ?? const Uuid().v4(),
        time = time ?? DateTime.now();

  Map<String, dynamic> get macros => {
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
  };

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type.name,
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
  };
}

@HiveType(typeId: 15)
enum WorkoutType {
  @HiveField(0)
  running,
  @HiveField(1)
  walking,
  @HiveField(2)
  cycling,
  @HiveField(3)
  swimming,
  @HiveField(4)
  strength,
  @HiveField(5)
  hiit,
  @HiveField(6)
  yoga,
  @HiveField(7)
  sports,
  @HiveField(8)
  other,
}

@HiveType(typeId: 16)
enum MealType {
  @HiveField(0)
  breakfast,
  @HiveField(1)
  lunch,
  @HiveField(2)
  dinner,
  @HiveField(3)
  snack,
}
