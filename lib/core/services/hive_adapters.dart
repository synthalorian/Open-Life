// Hive Type Adapters for Open Life
// In production, run: flutter pub run build_runner build

import 'package:hive/hive.dart';

// ==================== USER PROFILE ====================

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 0;

  @override
  UserProfile read(BinaryReader reader) {
    return UserProfile(
      name: reader.read(),
      email: reader.read(),
      dateOfBirth: reader.read(),
      profileImagePath: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer.write(obj.name);
    writer.write(obj.email);
    writer.write(obj.dateOfBirth);
    writer.write(obj.profileImagePath);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }
}

class UserPreferencesAdapter extends TypeAdapter<UserPreferences> {
  @override
  final int typeId = 1;

  @override
  UserPreferences read(BinaryReader reader) {
    return UserPreferences(
      darkModeEnabled: reader.read(),
      notificationsEnabled: reader.read(),
      aiInsightsEnabled: reader.read(),
      openAIApiKey: reader.read(),
      preferredAIModel: reader.read(),
      dailyStepGoal: reader.read(),
      dailyCalorieGoal: reader.read(),
      monthlyBudgetLimit: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, UserPreferences obj) {
    writer.write(obj.darkModeEnabled);
    writer.write(obj.notificationsEnabled);
    writer.write(obj.aiInsightsEnabled);
    writer.write(obj.openAIApiKey);
    writer.write(obj.preferredAIModel);
    writer.write(obj.dailyStepGoal);
    writer.write(obj.dailyCalorieGoal);
    writer.write(obj.monthlyBudgetLimit);
  }
}

// ==================== FITNESS ====================

class FitnessDataAdapter extends TypeAdapter<FitnessData> {
  @override
  final int typeId = 10;

  @override
  FitnessData read(BinaryReader reader) {
    return FitnessData(
      id: reader.read(),
      date: reader.read(),
      steps: reader.read(),
      stepsGoal: reader.read(),
      activeMinutes: reader.read(),
      caloriesBurned: reader.read(),
      restingHeartRate: reader.read(),
      heartRateSamples: reader.read(),
      sleep: reader.read(),
      workouts: reader.read(),
      meals: reader.read(),
      calorieGoal: reader.read(),
      weight: reader.read(),
      bodyFatPercentage: reader.read(),
      moodRating: reader.read(),
      energyLevel: reader.read(),
      stressLevel: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, FitnessData obj) {
    writer.write(obj.id);
    writer.write(obj.date);
    writer.write(obj.steps);
    writer.write(obj.stepsGoal);
    writer.write(obj.activeMinutes);
    writer.write(obj.caloriesBurned);
    writer.write(obj.restingHeartRate);
    writer.write(obj.heartRateSamples);
    writer.write(obj.sleep);
    writer.write(obj.workouts);
    writer.write(obj.meals);
    writer.write(obj.calorieGoal);
    writer.write(obj.weight);
    writer.write(obj.bodyFatPercentage);
    writer.write(obj.moodRating);
    writer.write(obj.energyLevel);
    writer.write(obj.stressLevel);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }
}

class SleepDataAdapter extends TypeAdapter<SleepData> {
  @override
  final int typeId = 11;

  @override
  SleepData read(BinaryReader reader) {
    return SleepData(
      startTime: reader.read(),
      endTime: reader.read(),
      deepSleepMinutes: reader.read(),
      remSleepMinutes: reader.read(),
      lightSleepMinutes: reader.read(),
      awakeMinutes: reader.read(),
      sleepQuality: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, SleepData obj) {
    writer.write(obj.startTime);
    writer.write(obj.endTime);
    writer.write(obj.deepSleepMinutes);
    writer.write(obj.remSleepMinutes);
    writer.write(obj.lightSleepMinutes);
    writer.write(obj.awakeMinutes);
    writer.write(obj.sleepQuality);
  }
}

class WorkoutAdapter extends TypeAdapter<Workout> {
  @override
  final int typeId = 12;

  @override
  Workout read(BinaryReader reader) {
    return Workout(
      id: reader.read(),
      name: reader.read(),
      type: reader.read(),
      durationMinutes: reader.read(),
      caloriesBurned: reader.read(),
      averageHeartRate: reader.read(),
      maxHeartRate: reader.read(),
      startTime: reader.read(),
      notes: reader.read(),
      exercises: reader.read(),
      intensity: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Workout obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.type);
    writer.write(obj.durationMinutes);
    writer.write(obj.caloriesBurned);
    writer.write(obj.averageHeartRate);
    writer.write(obj.maxHeartRate);
    writer.write(obj.startTime);
    writer.write(obj.notes);
    writer.write(obj.exercises);
    writer.write(obj.intensity);
  }
}

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 13;

  @override
  Exercise read(BinaryReader reader) {
    return Exercise(
      name: reader.read(),
      sets: reader.read(),
      reps: reader.read(),
      weight: reader.read(),
      durationSeconds: reader.read(),
      notes: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer.write(obj.name);
    writer.write(obj.sets);
    writer.write(obj.reps);
    writer.write(obj.weight);
    writer.write(obj.durationSeconds);
    writer.write(obj.notes);
  }
}

class MealAdapter extends TypeAdapter<Meal> {
  @override
  final int typeId = 14;

  @override
  Meal read(BinaryReader reader) {
    return Meal(
      id: reader.read(),
      name: reader.read(),
      type: reader.read(),
      time: reader.read(),
      calories: reader.read(),
      protein: reader.read(),
      carbs: reader.read(),
      fat: reader.read(),
      notes: reader.read(),
      aiAnalysis: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Meal obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.type);
    writer.write(obj.time);
    writer.write(obj.calories);
    writer.write(obj.protein);
    writer.write(obj.carbs);
    writer.write(obj.fat);
    writer.write(obj.notes);
    writer.write(obj.aiAnalysis);
  }
}

class WorkoutTypeAdapter extends TypeAdapter<WorkoutType> {
  @override
  final int typeId = 15;

  @override
  WorkoutType read(BinaryReader reader) {
    return WorkoutType.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, WorkoutType obj) {
    writer.writeByte(obj.index);
  }
}

class MealTypeAdapter extends TypeAdapter<MealType> {
  @override
  final int typeId = 16;

  @override
  MealType read(BinaryReader reader) {
    return MealType.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, MealType obj) {
    writer.writeByte(obj.index);
  }
}

// ==================== FINANCE ====================

class FinanceDataAdapter extends TypeAdapter<FinanceData> {
  @override
  final int typeId = 20;

  @override
  FinanceData read(BinaryReader reader) {
    return FinanceData(
      id: reader.read(),
      date: reader.read(),
      totalBalance: reader.read(),
      monthlyIncome: reader.read(),
      monthlyExpenses: reader.read(),
      transactions: reader.read(),
      budgets: reader.read(),
      savingsGoals: reader.read(),
      subscriptions: reader.read(),
      stressRelatedSpending: reader.read(),
      impulsePurchaseCategories: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, FinanceData obj) {
    writer.write(obj.id);
    writer.write(obj.date);
    writer.write(obj.totalBalance);
    writer.write(obj.monthlyIncome);
    writer.write(obj.monthlyExpenses);
    writer.write(obj.transactions);
    writer.write(obj.budgets);
    writer.write(obj.savingsGoals);
    writer.write(obj.subscriptions);
    writer.write(obj.stressRelatedSpending);
    writer.write(obj.impulsePurchaseCategories);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }
}

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 21;

  @override
  Transaction read(BinaryReader reader) {
    return Transaction(
      id: reader.read(),
      name: reader.read(),
      category: reader.read(),
      amount: reader.read(),
      isExpense: reader.read(),
      date: reader.read(),
      merchant: reader.read(),
      notes: reader.read(),
      aiCategorization: reader.read(),
      isRecurring: reader.read(),
      isImpulse: reader.read(),
      stressLevel: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.category);
    writer.write(obj.amount);
    writer.write(obj.isExpense);
    writer.write(obj.date);
    writer.write(obj.merchant);
    writer.write(obj.notes);
    writer.write(obj.aiCategorization);
    writer.write(obj.isRecurring);
    writer.write(obj.isImpulse);
    writer.write(obj.stressLevel);
  }
}

class BudgetAdapter extends TypeAdapter<Budget> {
  @override
  final int typeId = 22;

  @override
  Budget read(BinaryReader reader) {
    return Budget(
      id: reader.read(),
      name: reader.read(),
      category: reader.read(),
      limit: reader.read(),
      spent: reader.read(),
      aiRecommendation: reader.read(),
      isAIRecommended: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Budget obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.category);
    writer.write(obj.limit);
    writer.write(obj.spent);
    writer.write(obj.aiRecommendation);
    writer.write(obj.isAIRecommended);
  }
}

class SavingsGoalAdapter extends TypeAdapter<SavingsGoal> {
  @override
  final int typeId = 23;

  @override
  SavingsGoal read(BinaryReader reader) {
    return SavingsGoal(
      id: reader.read(),
      name: reader.read(),
      target: reader.read(),
      current: reader.read(),
      deadline: reader.read(),
      aiTimeline: reader.read(),
      aiSuggestedMonthlyContribution: reader.read(),
      isHealthRelated: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, SavingsGoal obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.target);
    writer.write(obj.current);
    writer.write(obj.deadline);
    writer.write(obj.aiTimeline);
    writer.write(obj.aiSuggestedMonthlyContribution);
    writer.write(obj.isHealthRelated);
  }
}

class SubscriptionAdapter extends TypeAdapter<Subscription> {
  @override
  final int typeId = 24;

  @override
  Subscription read(BinaryReader reader) {
    return Subscription(
      id: reader.read(),
      name: reader.read(),
      monthlyCost: reader.read(),
      category: reader.read(),
      nextBillingDate: reader.read(),
      isUnused: reader.read(),
      aiAlternative: reader.read(),
      annualSavings: reader.read(),
      isDebt: reader.read(),
      balance: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Subscription obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.monthlyCost);
    writer.write(obj.category);
    writer.write(obj.nextBillingDate);
    writer.write(obj.isUnused);
    writer.write(obj.aiAlternative);
    writer.write(obj.annualSavings);
    writer.write(obj.isDebt);
    writer.write(obj.balance);
  }
}

// ==================== ASSURANCE ====================

class AssuranceDataAdapter extends TypeAdapter<AssuranceData> {
  @override
  final int typeId = 30;

  @override
  AssuranceData read(BinaryReader reader) {
    return AssuranceData(
      id: reader.read(),
      date: reader.read(),
      bloodPressureSystolic: reader.read(),
      bloodPressureDiastolic: reader.read(),
      weight: reader.read(),
      height: reader.read(),
      bmi: reader.read(),
      restingHeartRate: reader.read(),
      insurancePolicies: reader.read(),
      appointments: reader.read(),
      medications: reader.read(),
      documents: reader.read(),
      emergencyContacts: reader.read(),
      metricHistory: reader.read(),
      stressLevel: reader.read(),
      sleepQuality: reader.read(),
      energyLevel: reader.read(),
      aiHealthSummary: reader.read(),
      aiRecommendations: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, AssuranceData obj) {
    writer.write(obj.id);
    writer.write(obj.date);
    writer.write(obj.bloodPressureSystolic);
    writer.write(obj.bloodPressureDiastolic);
    writer.write(obj.weight);
    writer.write(obj.height);
    writer.write(obj.bmi);
    writer.write(obj.restingHeartRate);
    writer.write(obj.insurancePolicies);
    writer.write(obj.appointments);
    writer.write(obj.medications);
    writer.write(obj.documents);
    writer.write(obj.emergencyContacts);
    writer.write(obj.metricHistory);
    writer.write(obj.stressLevel);
    writer.write(obj.sleepQuality);
    writer.write(obj.energyLevel);
    writer.write(obj.aiHealthSummary);
    writer.write(obj.aiRecommendations);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }
}

class InsurancePolicyAdapter extends TypeAdapter<InsurancePolicy> {
  @override
  final int typeId = 31;

  @override
  InsurancePolicy read(BinaryReader reader) {
    return InsurancePolicy(
      id: reader.read(),
      name: reader.read(),
      provider: reader.read(),
      policyNumber: reader.read(),
      type: reader.read(),
      coverageLimit: reader.read(),
      deductible: reader.read(),
      monthlyPremium: reader.read(),
      effectiveDate: reader.read(),
      expirationDate: reader.read(),
      isActive: reader.read(),
      aiCoverageSummary: reader.read(),
      coveredServices: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, InsurancePolicy obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.provider);
    writer.write(obj.policyNumber);
    writer.write(obj.type);
    writer.write(obj.coverageLimit);
    writer.write(obj.deductible);
    writer.write(obj.monthlyPremium);
    writer.write(obj.effectiveDate);
    writer.write(obj.expirationDate);
    writer.write(obj.isActive);
    writer.write(obj.aiCoverageSummary);
    writer.write(obj.coveredServices);
  }
}

class AppointmentAdapter extends TypeAdapter<Appointment> {
  @override
  final int typeId = 32;

  @override
  Appointment read(BinaryReader reader) {
    return Appointment(
      id: reader.read(),
      doctorName: reader.read(),
      specialty: reader.read(),
      date: reader.read(),
      time: reader.read(),
      location: reader.read(),
      notes: reader.read(),
      isCompleted: reader.read(),
      aiSuggestedQuestions: reader.read(),
      followUpNeeded: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Appointment obj) {
    writer.write(obj.id);
    writer.write(obj.doctorName);
    writer.write(obj.specialty);
    writer.write(obj.date);
    writer.write(obj.time);
    writer.write(obj.location);
    writer.write(obj.notes);
    writer.write(obj.isCompleted);
    writer.write(obj.aiSuggestedQuestions);
    writer.write(obj.followUpNeeded);
  }
}

class MedicationAdapter extends TypeAdapter<Medication> {
  @override
  final int typeId = 33;

  @override
  Medication read(BinaryReader reader) {
    return Medication(
      id: reader.read(),
      name: reader.read(),
      dosage: reader.read(),
      frequency: reader.read(),
      instructions: reader.read(),
      refillsRemaining: reader.read(),
      lastRefillDate: reader.read(),
      isActive: reader.read(),
      takenHistory: reader.read(),
      prescribedBy: reader.read(),
      pharmacy: reader.read(),
      nextRefillDate: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Medication obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.dosage);
    writer.write(obj.frequency);
    writer.write(obj.instructions);
    writer.write(obj.refillsRemaining);
    writer.write(obj.lastRefillDate);
    writer.write(obj.isActive);
    writer.write(obj.takenHistory);
    writer.write(obj.prescribedBy);
    writer.write(obj.pharmacy);
    writer.write(obj.nextRefillDate);
  }
}

class HealthDocumentAdapter extends TypeAdapter<HealthDocument> {
  @override
  final int typeId = 34;

  @override
  HealthDocument read(BinaryReader reader) {
    return HealthDocument(
      id: reader.read(),
      title: reader.read(),
      type: reader.read(),
      filePath: reader.read(),
      date: reader.read(),
      aiSummary: reader.read(),
      aiKeyFindings: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, HealthDocument obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.type);
    writer.write(obj.filePath);
    writer.write(obj.date);
    writer.write(obj.aiSummary);
    writer.write(obj.aiKeyFindings);
  }
}

class EmergencyContactAdapter extends TypeAdapter<EmergencyContact> {
  @override
  final int typeId = 35;

  @override
  EmergencyContact read(BinaryReader reader) {
    return EmergencyContact(
      id: reader.read(),
      name: reader.read(),
      relationship: reader.read(),
      phone: reader.read(),
      email: reader.read(),
      isPrimary: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, EmergencyContact obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.relationship);
    writer.write(obj.phone);
    writer.write(obj.email);
    writer.write(obj.isPrimary);
  }
}

class HealthMetricAdapter extends TypeAdapter<HealthMetric> {
  @override
  final int typeId = 36;

  @override
  HealthMetric read(BinaryReader reader) {
    return HealthMetric(
      type: reader.read(),
      value: reader.read(),
      date: reader.read(),
      unit: reader.read(),
      notes: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, HealthMetric obj) {
    writer.write(obj.type);
    writer.write(obj.value);
    writer.write(obj.date);
    writer.write(obj.unit);
    writer.write(obj.notes);
  }
}

class HealthStatusAdapter extends TypeAdapter<HealthStatus> {
  @override
  final int typeId = 37;

  @override
  HealthStatus read(BinaryReader reader) {
    return HealthStatus.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, HealthStatus obj) {
    writer.writeByte(obj.index);
  }
}
