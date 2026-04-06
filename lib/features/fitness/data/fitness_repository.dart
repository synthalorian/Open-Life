import 'package:hive/hive.dart';
import '../../../shared/models/fitness_data.dart';

class FitnessRepository {
  static const String _boxName = 'fitness_data';
  Box<FitnessData>? _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<FitnessData>(_boxName);
    } else {
      _box = Hive.box<FitnessData>(_boxName);
    }
  }

  Box<FitnessData> get box {
    if (_box == null) throw StateError('FitnessRepository not initialized. Call init() first.');
    return _box!;
  }

  // Daily fitness data
  Future<void> saveDailyData(FitnessData data) async {
    final key = _dateKey(data.date);
    await box.put(key, data);
  }

  FitnessData? getDailyData(DateTime date) {
    return box.get(_dateKey(date));
  }

  FitnessData getOrCreateDailyData(DateTime date) {
    final key = _dateKey(date);
    return box.get(key) ?? FitnessData(date: date);
  }

  // Today's data (convenience)
  FitnessData get todayData => getOrCreateDailyData(DateTime.now());

  // Update specific fields
  Future<void> updateSteps(DateTime date, int steps) async {
    final data = getOrCreateDailyData(date);
    final updated = data.copyWith(steps: steps);
    await saveDailyData(updated);
  }

  Future<void> addWorkout(DateTime date, Workout workout) async {
    final data = getOrCreateDailyData(date);
    final updatedWorkouts = [...data.workouts, workout];
    final updated = data.copyWith(workouts: updatedWorkouts);
    await saveDailyData(updated);
  }

  Future<void> addMeal(DateTime date, Meal meal) async {
    final data = getOrCreateDailyData(date);
    final updatedMeals = [...data.meals, meal];
    final updated = data.copyWith(meals: updatedMeals);
    await saveDailyData(updated);
  }

  Future<void> updateSleep(DateTime date, SleepData sleep) async {
    final data = getOrCreateDailyData(date);
    final updated = data.copyWith(sleep: sleep);
    await saveDailyData(updated);
  }

  Future<void> updateMood(DateTime date, int? mood, int? energy, int? stress) async {
    final data = getOrCreateDailyData(date);
    final updated = data.copyWith(
      moodRating: mood,
      energyLevel: energy,
      stressLevel: stress,
    );
    await saveDailyData(updated);
  }

  // Historical data
  List<FitnessData> getLastNDays(int days) {
    final result = <FitnessData>[];
    final now = DateTime.now();
    
    for (int i = 0; i < days; i++) {
      final date = now.subtract(Duration(days: i));
      final data = getDailyData(date);
      if (data != null) {
        result.add(data);
      }
    }
    
    return result.reversed.toList();
  }

  // Weekly stats
  Map<String, dynamic> getWeeklyStats() {
    final weekData = getLastNDays(7);
    
    if (weekData.isEmpty) return {};

    final totalSteps = weekData.fold(0, (sum, d) => sum + d.steps);
    final avgSteps = totalSteps / weekData.length;
    final totalWorkouts = weekData.fold(0, (sum, d) => sum + d.workoutCount);
    final totalCaloriesBurned = weekData.fold(0, (sum, d) => sum + d.caloriesBurned);
    final totalActiveMinutes = weekData.fold(0, (sum, d) => sum + d.activeMinutes);

    return {
      'totalSteps': totalSteps,
      'avgSteps': avgSteps.toInt(),
      'totalWorkouts': totalWorkouts,
      'totalCaloriesBurned': totalCaloriesBurned,
      'totalActiveMinutes': totalActiveMinutes,
      'daysTracked': weekData.length,
    };
  }

  // For AI analysis
  List<Map<String, dynamic>> getDataForAI({int days = 30}) {
    return getLastNDays(days).map((d) => d.toJson()).toList();
  }

  // Helper methods
  String _dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // Clear all data (for testing/reset)
  Future<void> clearAll() async {
    await box.clear();
  }
}
