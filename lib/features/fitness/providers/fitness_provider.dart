import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../main.dart';
import '../../data/fitness_repository.dart';
import '../../../shared/models/fitness_data.dart';

class FitnessState {
  final FitnessData? todayData;
  final List<FitnessData> last7Days;
  final Map<String, dynamic> weeklyStats;
  final String? aiInsight;
  final bool isLoading;
  final String? error;

  const FitnessState({
    this.todayData,
    this.last7Days = const [],
    this.weeklyStats = const {},
    this.aiInsight,
    this.isLoading = false,
    this.error,
  });

  FitnessState copyWith({
    FitnessData? todayData,
    List<FitnessData>? last7Days,
    Map<String, dynamic>? weeklyStats,
    String? aiInsight,
    bool? isLoading,
    String? error,
  }) {
    return FitnessState(
      todayData: todayData ?? this.todayData,
      last7Days: last7Days ?? this.last7Days,
      weeklyStats: weeklyStats ?? this.weeklyStats,
      aiInsight: aiInsight ?? this.aiInsight,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  // Computed getters
  int get steps => todayData?.steps ?? 0;
  int get stepsGoal => todayData?.stepsGoal ?? 10000;
  double get stepsPercentage => todayData?.stepsPercentage ?? 0;
  int get caloriesBurned => todayData?.caloriesBurned ?? 0;
  int get consumedCalories => todayData?.consumedCalories ?? 0;
  int get caloriesRemaining => todayData?.caloriesRemaining ?? 0;
  int get activeMinutes => todayData?.activeMinutes ?? 0;
  int get workoutCount => todayData?.workoutCount ?? 0;
  bool get hitStepsGoal => todayData?.hitStepsGoal ?? false;
  List<Workout> get workouts => todayData?.workouts ?? [];
  List<Meal> get meals => todayData?.meals ?? [];
  SleepData? get sleep => todayData?.sleep;
  int? get moodRating => todayData?.moodRating;
  int? get energyLevel => todayData?.energyLevel;
  int? get stressLevel => todayData?.stressLevel;
}

class FitnessNotifier extends StateNotifier<FitnessState> {
  final FitnessRepository _repository;

  FitnessNotifier(this._repository) : super(const FitnessState()) {
    _loadFitnessData();
  }

  Future<void> _loadFitnessData() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final todayData = _repository.todayData;
      final last7Days = _repository.getLastNDays(7);
      final weeklyStats = _repository.getWeeklyStats();
      
      // Generate AI insight based on data
      final aiInsight = _generateAIInsight(todayData, weeklyStats);
      
      state = state.copyWith(
        todayData: todayData,
        last7Days: last7Days,
        weeklyStats: weeklyStats,
        aiInsight: aiInsight,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load fitness data: $e',
      );
    }
  }

  Future<void> updateSteps(int steps) async {
    await _repository.updateSteps(DateTime.now(), steps);
    await _loadFitnessData();
  }

  Future<void> addWorkout(Workout workout) async {
    await _repository.addWorkout(DateTime.now(), workout);
    await _loadFitnessData();
  }

  Future<void> addMeal(Meal meal) async {
    await _repository.addMeal(DateTime.now(), meal);
    await _loadFitnessData();
  }

  Future<void> updateSleep(SleepData sleep) async {
    await _repository.updateSleep(DateTime.now(), sleep);
    await _loadFitnessData();
  }

  Future<void> updateMood({int? mood, int? energy, int? stress}) async {
    await _repository.updateMood(DateTime.now(), mood, energy, stress);
    await _loadFitnessData();
  }

  Future<void> refresh() async {
    await _loadFitnessData();
  }

  String _generateAIInsight(FitnessData today, Map<String, dynamic> weeklyStats) {
    final steps = today.steps;
    final goal = today.stepsGoal;
    final percentage = (steps / goal * 100).round();
    
    if (percentage >= 100) {
      return '🎉 Goal crushed! You\'ve hit ${percentage}% of your step goal. Great work!';
    } else if (percentage >= 80) {
      final remaining = goal - steps;
      return 'Almost there! Just $remaining more steps to hit your goal. A 10-minute walk will do it!';
    } else if (percentage >= 50) {
      return 'You\'re at ${percentage}% of your goal. Keep moving!';
    } else {
      return 'Let\'s get moving! You\'re at ${percentage}% of your daily step goal.';
    }
  }

  Map<String, dynamic> getDataForAI() {
    return {
      'today': todayData?.toJson(),
      'weeklyStats': weeklyStats,
      'last7Days': last7Days.map((d) => d.toJson()).toList(),
    };
  }
}

final fitnessProvider = StateNotifierProvider<FitnessNotifier, FitnessState>((ref) {
  final repository = ref.watch(fitnessRepositoryProvider);
  return FitnessNotifier(repository);
});
