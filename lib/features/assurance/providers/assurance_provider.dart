import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../data/assurance_repository.dart';
import '../../../shared/models/assurance_data.dart';
import '../../../core/theme/app_colors.dart';

class AssuranceState {
  final AssuranceData? currentData;
  final List<InsurancePolicy> policies;
  final List<Appointment> upcomingAppointments;
  final List<Appointment> pastAppointments;
  final List<Medication> medications;
  final List<Medication> medicationsNeedingRefill;
  final List<EmergencyContact> emergencyContacts;
  final String? aiInsight;
  final bool isLoading;
  final String? error;

  const AssuranceState({
    this.currentData,
    this.policies = const [],
    this.upcomingAppointments = const [],
    this.pastAppointments = const [],
    this.medications = const [],
    this.medicationsNeedingRefill = const [],
    this.emergencyContacts = const [],
    this.aiInsight,
    this.isLoading = false,
    this.error,
  });

  AssuranceState copyWith({
    AssuranceData? currentData,
    List<InsurancePolicy>? policies,
    List<Appointment>? upcomingAppointments,
    List<Appointment>? pastAppointments,
    List<Medication>? medications,
    List<Medication>? medicationsNeedingRefill,
    List<EmergencyContact>? emergencyContacts,
    String? aiInsight,
    bool? isLoading,
    String? error,
  }) {
    return AssuranceState(
      currentData: currentData ?? this.currentData,
      policies: policies ?? this.policies,
      upcomingAppointments: upcomingAppointments ?? this.upcomingAppointments,
      pastAppointments: pastAppointments ?? this.pastAppointments,
      medications: medications ?? this.medications,
      medicationsNeedingRefill: medicationsNeedingRefill ?? this.medicationsNeedingRefill,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      aiInsight: aiInsight ?? this.aiInsight,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  // Computed getters
  String? get bloodPressure => currentData?.bloodPressure;
  double? get weight => currentData?.weight;
  double? get bmi => currentData?.bmiCalculated;
  int? get restingHeartRate => currentData?.restingHeartRate;
  bool get hasHighBloodPressure => currentData?.hasHighBloodPressure ?? false;
  int get activeMedications => medications.where((m) => m.isActive).length;
  Appointment? get nextAppointment => upcomingAppointments.isNotEmpty ? upcomingAppointments.first : null;
  EmergencyContact? get primaryEmergencyContact => emergencyContacts.isNotEmpty 
    ? emergencyContacts.firstWhere((c) => c.isPrimary, orElse: () => emergencyContacts.first) 
    : null;
}

class AssuranceNotifier extends StateNotifier<AssuranceState> {
  final AssuranceRepository _repository;

  AssuranceNotifier(this._repository) : super(const AssuranceState()) {
    _loadAssuranceData();
  }

  Future<void> _loadAssuranceData() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final currentData = _repository.currentData;
      final policies = _repository.getPolicies();
      final upcomingAppointments = _repository.getUpcomingAppointments();
      final pastAppointments = _repository.getPastAppointments();
      final medications = _repository.getMedications();
      final medicationsNeedingRefill = _repository.getMedicationsNeedingRefill();
      final emergencyContacts = _repository.getEmergencyContacts();
      
      final aiInsight = _generateAIInsight(
        currentData,
        medicationsNeedingRefill,
        upcomingAppointments,
      );
      
      state = state.copyWith(
        currentData: currentData,
        policies: policies,
        upcomingAppointments: upcomingAppointments,
        pastAppointments: pastAppointments,
        medications: medications,
        medicationsNeedingRefill: medicationsNeedingRefill,
        emergencyContacts: emergencyContacts,
        aiInsight: aiInsight,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load health data: $e',
      );
    }
  }

  Future<void> savePolicy(InsurancePolicy policy) async {
    await _repository.savePolicy(policy);
    await _loadAssuranceData();
  }

  Future<void> deletePolicy(String id) async {
    await _repository.deletePolicy(id);
    await _loadAssuranceData();
  }

  Future<void> saveAppointment(Appointment appointment) async {
    await _repository.saveAppointment(appointment);
    await _loadAssuranceData();
  }

  Future<void> markAppointmentComplete(String id) async {
    await _repository.markAppointmentComplete(id);
    await _loadAssuranceData();
  }

  Future<void> saveMedication(Medication medication) async {
    await _repository.saveMedication(medication);
    await _loadAssuranceData();
  }

  Future<void> recordMedicationTaken(String id) async {
    await _repository.recordMedicationTaken(id);
    await _loadAssuranceData();
  }

  Future<void> saveEmergencyContact(EmergencyContact contact) async {
    await _repository.saveEmergencyContact(contact);
    await _loadAssuranceData();
  }

  Future<void> addHealthMetric(HealthMetric metric) async {
    await _repository.addMetric(metric);
    await _loadAssuranceData();
  }

  Future<void> refresh() async {
    await _loadAssuranceData();
  }

  String _generateAIInsight(
    AssuranceData? data,
    List<Medication> needingRefill,
    List<Appointment> upcoming,
  ) {
    final List<String> insights = [];
    
    // Check medications needing refill
    if (needingRefill.isNotEmpty) {
      final names = needingRefill.map((m) => m.name).join(', ');
      insights.add('⚠️ You need to refill: $names');
    }
    
    // Check upcoming appointments
    if (upcoming.isNotEmpty) {
      final next = upcoming.first;
      if (next.daysUntil <= 3) {
        insights.add('📅 Your appointment with ${next.doctorName} is in ${next.daysUntil} days!');
      }
    }
    
    // Check blood pressure
    if (data?.hasHighBloodPressure ?? false) {
      insights.add('⚠️ Your blood pressure is elevated. Consider scheduling a checkup.');
    }
    
    // Check insurance expiring
    final expiringPolicies = data?.insurancePolicies.where((p) => p.isExpiringSoon).toList() ?? [];
    if (expiringPolicies.isNotEmpty) {
      insights.add('📝 ${expiringPolicies.first.name} is expiring soon. Renew it!');
    }
    
    if (insights.isEmpty) {
      return '✅ Your health metrics look good! Keep maintaining your healthy habits.';
    }
    
    return insights.join('\n');
  }

  Map<String, dynamic> getDataForAI() {
    return _repository.getDataForAI();
  }
}

// Helper extension for UI
extension AppointmentUI on Appointment {
  IconData get icon {
    return switch (specialty.toLowerCase()) {
      'dentist' || 'dental' => PhosphorIcons.tooth(),
      'eye' || 'vision' || 'optometry' => PhosphorIcons.eye(),
      'heart' || 'cardiology' => PhosphorIcons.heartbeat(),
      'mental' || 'therapy' || 'psychiatry' => PhosphorIcons.brain(),
      _ => PhosphorIcons.stethoscope(),
    };
  }
}

extension InsurancePolicyUI on InsurancePolicy {
  IconData get icon {
    return switch (type.toLowerCase()) {
      'health' => PhosphorIcons.heart(),
      'dental' => PhosphorIcons.tooth(),
      'vision' => PhosphorIcons.eye(),
      'life' => PhosphorIcons.shield(),
      _ => PhosphorIcons.shieldCheck(),
    };
  }

  Color get color {
    return switch (type.toLowerCase()) {
      'health' => AppColors.assurancePrimary,
      'dental' => AppColors.cyan,
      'vision' => AppColors.electricPurple,
      'life' => AppColors.financePrimary,
      _ => AppColors.neonPink,
    };
  }
}

final assuranceRepositoryProvider = Provider<AssuranceRepository>((ref) {
  final repo = AssuranceRepository();
  return repo;
});

final assuranceProvider = StateNotifierProvider<AssuranceNotifier, AssuranceState>((ref) {
  final repository = ref.watch(assuranceRepositoryProvider);
  return AssuranceNotifier(repository);
});
