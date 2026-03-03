import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'features/fitness/data/fitness_repository.dart';
import 'features/finance/data/finance_repository.dart';
import 'features/assurance/data/assurance_repository.dart';
import 'core/services/hive_adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive adapters
  _registerHiveAdapters();
  
  // Initialize repositories
  await _initializeRepositories();
  
  runApp(
    const ProviderScope(
      child: OpenLifeApp(),
    ),
  );
}

void _registerHiveAdapters() {
  // User profile
  Hive.registerAdapter(UserProfileAdapter());
  Hive.registerAdapter(UserPreferencesAdapter());
  
  // Fitness
  Hive.registerAdapter(FitnessDataAdapter());
  Hive.registerAdapter(SleepDataAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(WorkoutTypeAdapter());
  Hive.registerAdapter(MealTypeAdapter());
  
  // Finance
  Hive.registerAdapter(FinanceDataAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(SavingsGoalAdapter());
  Hive.registerAdapter(SubscriptionAdapter());
  
  // Assurance
  Hive.registerAdapter(AssuranceDataAdapter());
  Hive.registerAdapter(InsurancePolicyAdapter());
  Hive.registerAdapter(AppointmentAdapter());
  Hive.registerAdapter(MedicationAdapter());
  Hive.registerAdapter(HealthDocumentAdapter());
  Hive.registerAdapter(EmergencyContactAdapter());
  Hive.registerAdapter(HealthMetricAdapter());
  Hive.registerAdapter(HealthStatusAdapter());
}

Future<void> _initializeRepositories() async {
  await FitnessRepository().init();
  await FinanceRepository().init();
  await AssuranceRepository().init();
  
  // Open user preferences box
  await Hive.openBox<UserProfile>('user_profile');
  await Hive.openBox<UserPreferences>('user_preferences');
}

// Global repository providers for easy access
final fitnessRepositoryProvider = Provider<FitnessRepository>((ref) => FitnessRepository());
final financeRepositoryProvider = Provider<FinanceRepository>((ref) => FinanceRepository());
final assuranceRepositoryProvider = Provider<AssuranceRepository>((ref) => AssuranceRepository());
