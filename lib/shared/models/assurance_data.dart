import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';


@HiveType(typeId: 30)
class AssuranceData extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  // Vital signs
  @HiveField(2)
  int? bloodPressureSystolic;

  @HiveField(3)
  int? bloodPressureDiastolic;

  @HiveField(4)
  double? weight;

  @HiveField(5)
  double? height; // in inches

  @HiveField(6)
  double? bmi;

  @HiveField(7)
  int? restingHeartRate;

  // Insurance
  @HiveField(8)
  List<InsurancePolicy> insurancePolicies;

  @HiveField(9)
  List<Appointment> appointments;

  @HiveField(10)
  List<Medication> medications;

  @HiveField(11)
  List<HealthDocument> documents;

  // Emergency
  @HiveField(12)
  List<EmergencyContact> emergencyContacts;

  // Health metrics history
  @HiveField(13)
  List<HealthMetric> metricHistory;

  // Correlation data (for AI insights)
  @HiveField(14)
  int? stressLevel; // 1-10

  @HiveField(15)
  int? sleepQuality; // 1-10

  @HiveField(16)
  int? energyLevel; // 1-10

  @HiveField(17)
  String? aiHealthSummary; // AI-generated health summary

  @HiveField(18)
  List<String> aiRecommendations;

  @HiveField(19)
  DateTime createdAt;

  @HiveField(20)
  DateTime updatedAt;

  AssuranceData({
    String? id,
    DateTime? date,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.weight,
    this.height,
    this.bmi,
    this.restingHeartRate,
    this.insurancePolicies = const [],
    this.appointments = const [],
    this.medications = const [],
    this.documents = const [],
    this.emergencyContacts = const [],
    this.metricHistory = const [],
    this.stressLevel,
    this.sleepQuality,
    this.energyLevel,
    this.aiHealthSummary,
    this.aiRecommendations = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Computed properties
  String? get bloodPressure => bloodPressureSystolic != null && bloodPressureDiastolic != null
    ? '$bloodPressureSystolic/$bloodPressureDiastolic'
    : null;

  double? get bmiCalculated => (weight != null && height != null && height! > 0)
    ? (weight! * 703) / (height! * height!)
    : null;

  bool get hasHighBloodPressure => (bloodPressureSystolic ?? 0) > 130 || (bloodPressureDiastolic ?? 0) > 80;

  int get upcomingAppointments => appointments.where((a) => a.date.isAfter(DateTime.now())).length;

  int get activeMedications => medications.where((m) => m.isActive).length;

  List<Appointment> get nextAppointments => appointments
    .where((a) => a.date.isAfter(DateTime.now()))
    .toList()
    ..sort((a, b) => a.date.compareTo(b.date));

  List<Medication> get medicationsNeedingRefill => medications.where((m) => m.needsRefill).toList();

  AssuranceData copyWith({
    String? id,
    DateTime? date,
    int? bloodPressureSystolic,
    int? bloodPressureDiastolic,
    double? weight,
    double? height,
    double? bmi,
    int? restingHeartRate,
    List<InsurancePolicy>? insurancePolicies,
    List<Appointment>? appointments,
    List<Medication>? medications,
    List<HealthDocument>? documents,
    List<EmergencyContact>? emergencyContacts,
    List<HealthMetric>? metricHistory,
    int? stressLevel,
    int? sleepQuality,
    int? energyLevel,
    String? aiHealthSummary,
    List<String>? aiRecommendations,
  }) {
    return AssuranceData(
      id: id ?? this.id,
      date: date ?? this.date,
      bloodPressureSystolic: bloodPressureSystolic ?? this.bloodPressureSystolic,
      bloodPressureDiastolic: bloodPressureDiastolic ?? this.bloodPressureDiastolic,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
      restingHeartRate: restingHeartRate ?? this.restingHeartRate,
      insurancePolicies: insurancePolicies ?? this.insurancePolicies,
      appointments: appointments ?? this.appointments,
      medications: medications ?? this.medications,
      documents: documents ?? this.documents,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      metricHistory: metricHistory ?? this.metricHistory,
      stressLevel: stressLevel ?? this.stressLevel,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      energyLevel: energyLevel ?? this.energyLevel,
      aiHealthSummary: aiHealthSummary ?? this.aiHealthSummary,
      aiRecommendations: aiRecommendations ?? this.aiRecommendations,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'bloodPressure': bloodPressure,
    'weight': weight,
    'bmi': bmiCalculated?.toStringAsFixed(1),
    'restingHeartRate': restingHeartRate,
    'upcomingAppointments': upcomingAppointments,
    'activeMedications': activeMedications,
    'hasHighBloodPressure': hasHighBloodPressure,
    'stressLevel': stressLevel,
    'sleepQuality': sleepQuality,
  };
}

@HiveType(typeId: 31)
class InsurancePolicy extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String provider;

  @HiveField(3)
  String policyNumber;

  @HiveField(4)
  String type; // health, dental, vision, life, etc.

  @HiveField(5)
  double coverageLimit;

  @HiveField(6)
  double deductible;

  @HiveField(7)
  double monthlyPremium;

  @HiveField(8)
  DateTime? effectiveDate;

  @HiveField(9)
  DateTime? expirationDate;

  @HiveField(10)
  bool isActive;

  @HiveField(11)
  String? aiCoverageSummary; // AI explanation of what's covered

  @HiveField(12)
  List<String> coveredServices;

  InsurancePolicy({
    String? id,
    required this.name,
    required this.provider,
    required this.policyNumber,
    required this.type,
    this.coverageLimit = 0,
    this.deductible = 0,
    this.monthlyPremium = 0,
    this.effectiveDate,
    this.expirationDate,
    this.isActive = true,
    this.aiCoverageSummary,
    this.coveredServices = const [],
  }) : id = id ?? const Uuid().v4();

  double get annualPremium => monthlyPremium * 12;
  bool get isExpiringSoon => expirationDate != null && expirationDate!.difference(DateTime.now()).inDays < 30;

  Map<String, dynamic> toJson() => {
    'name': name,
    'provider': provider,
    'type': type,
    'coverageLimit': coverageLimit,
    'monthlyPremium': monthlyPremium,
    'isActive': isActive,
    'isExpiringSoon': isExpiringSoon,
  };
}

@HiveType(typeId: 32)
class Appointment extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String doctorName;

  @HiveField(2)
  String specialty;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String time;

  @HiveField(5)
  String? location;

  @HiveField(6)
  String? notes;

  @HiveField(7)
  bool isCompleted;

  @HiveField(8)
  List<String>? aiSuggestedQuestions; // Questions to ask doctor

  @HiveField(9)
  String? followUpNeeded;

  Appointment({
    String? id,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    this.location,
    this.notes,
    this.isCompleted = false,
    this.aiSuggestedQuestions,
    this.followUpNeeded,
  }) : id = id ?? const Uuid().v4();

  int get daysUntil => date.difference(DateTime.now()).inDays;
  bool get isToday => daysUntil == 0;
  bool get isPast => daysUntil < 0;
  bool get isUpcoming => daysUntil > 0 && daysUntil <= 7;

  Map<String, dynamic> toJson() => {
    'doctorName': doctorName,
    'specialty': specialty,
    'date': date.toIso8601String(),
    'time': time,
    'daysUntil': daysUntil,
    'isToday': isToday,
  };
}

@HiveType(typeId: 33)
class Medication extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String dosage;

  @HiveField(3)
  String frequency;

  @HiveField(4)
  String? instructions;

  @HiveField(5)
  int refillsRemaining;

  @HiveField(6)
  DateTime? lastRefillDate;

  @HiveField(7)
  bool isActive;

  @HiveField(8)
  List<DateTime> takenHistory; // Track when taken

  @HiveField(9)
  String? prescribedBy;

  @HiveField(10)
  String? pharmacy;

  @HiveField(11)
  DateTime? nextRefillDate;

  Medication({
    String? id,
    required this.name,
    required this.dosage,
    required this.frequency,
    this.instructions,
    this.refillsRemaining = 0,
    this.lastRefillDate,
    this.isActive = true,
    this.takenHistory = const [],
    this.prescribedBy,
    this.pharmacy,
    this.nextRefillDate,
  }) : id = id ?? const Uuid().v4();

  bool get needsRefill => refillsRemaining <= 1 || (nextRefillDate != null && nextRefillDate!.isBefore(DateTime.now().add(const Duration(days: 7))));
  double get adherenceRate {
    if (takenHistory.isEmpty) return 0;
    // Calculate based on expected doses vs taken
    final daysSinceStart = DateTime.now().difference(takenHistory.first).inDays;
    final expectedDoses = daysSinceStart * _dosesPerDay;
    return expectedDoses > 0 ? takenHistory.length / expectedDoses : 0;
  }

  int get _dosesPerDay {
    if (frequency.toLowerCase().contains('twice') || frequency.toLowerCase().contains('2x')) return 2;
    if (frequency.toLowerCase().contains('three') || frequency.toLowerCase().contains('3x')) return 3;
    return 1;
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'dosage': dosage,
    'frequency': frequency,
    'refillsRemaining': refillsRemaining,
    'needsRefill': needsRefill,
    'isActive': isActive,
  };
}

@HiveType(typeId: 34)
class HealthDocument extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String type; // lab_result, prescription, insurance_card, etc.

  @HiveField(3)
  String filePath;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  String? aiSummary; // AI-generated summary of document

  @HiveField(6)
  List<String>? aiKeyFindings;

  HealthDocument({
    String? id,
    required this.title,
    required this.type,
    required this.filePath,
    DateTime? date,
    this.aiSummary,
    this.aiKeyFindings,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'title': title,
    'type': type,
    'date': date.toIso8601String(),
    'hasAiSummary': aiSummary != null,
  };
}

@HiveType(typeId: 35)
class EmergencyContact extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String relationship;

  @HiveField(3)
  String phone;

  @HiveField(4)
  String? email;

  @HiveField(5)
  bool isPrimary;

  EmergencyContact({
    String? id,
    required this.name,
    required this.relationship,
    required this.phone,
    this.email,
    this.isPrimary = false,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    'name': name,
    'relationship': relationship,
    'phone': phone,
    'isPrimary': isPrimary,
  };
}

@HiveType(typeId: 36)
class HealthMetric extends HiveObject {
  @HiveField(0)
  String type; // weight, bp_systolic, bp_diastolic, heart_rate, etc.

  @HiveField(1)
  double value;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String? unit;

  @HiveField(4)
  String? notes;

  HealthMetric({
    required this.type,
    required this.value,
    DateTime? date,
    this.unit,
    this.notes,
  }) : date = date ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'type': type,
    'value': value,
    'date': date.toIso8601String(),
    'unit': unit,
  };
}

// Health status enum for quick AI analysis
@HiveType(typeId: 37)
enum HealthStatus {
  @HiveField(0)
  excellent,
  @HiveField(1)
  good,
  @HiveField(2)
  fair,
  @HiveField(3)
  needsAttention,
  @HiveField(4)
  critical,
}
