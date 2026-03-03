import 'package:hive/hive.dart';
import '../../../shared/models/assurance_data.dart';

class AssuranceRepository {
  static const String _boxName = 'assurance_data';
  static const String _policiesKey = 'policies';
  static const String _appointmentsKey = 'appointments';
  static const String _medicationsKey = 'medications';
  static const String _documentsKey = 'documents';
  static const String _emergencyContactsKey = 'emergency_contacts';
  static const String _metricHistoryKey = 'metric_history';
  
  Box? _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox(_boxName);
    } else {
      _box = Hive.box(_boxName);
    }
  }

  Box get box {
    if (_box == null) throw StateError('AssuranceRepository not initialized. Call init() first.');
    return _box!;
  }

  // Current health snapshot
  AssuranceData get currentData {
    return AssuranceData(
      insurancePolicies: getPolicies(),
      appointments: getAppointments(),
      medications: getMedications(),
      documents: getDocuments(),
      emergencyContacts: getEmergencyContacts(),
      metricHistory: getMetricHistory(),
    );
  }

  // Insurance Policies
  List<InsurancePolicy> getPolicies() {
    return box.get(_policiesKey, defaultValue: <InsurancePolicy>[])?.cast<InsurancePolicy>() ?? [];
  }

  Future<void> savePolicy(InsurancePolicy policy) async {
    final policies = getPolicies();
    final index = policies.indexWhere((p) => p.id == policy.id);
    
    if (index >= 0) {
      policies[index] = policy;
    } else {
      policies.add(policy);
    }
    
    await box.put(_policiesKey, policies);
  }

  Future<void> deletePolicy(String id) async {
    final policies = getPolicies()..removeWhere((p) => p.id == id);
    await box.put(_policiesKey, policies);
  }

  // Appointments
  List<Appointment> getAppointments() {
    return box.get(_appointmentsKey, defaultValue: <Appointment>[])?.cast<Appointment>() ?? [];
  }

  Future<void> saveAppointment(Appointment appointment) async {
    final appointments = getAppointments();
    final index = appointments.indexWhere((a) => a.id == appointment.id);
    
    if (index >= 0) {
      appointments[index] = appointment;
    } else {
      appointments.add(appointment);
    }
    
    await box.put(_appointmentsKey, appointments);
  }

  Future<void> markAppointmentComplete(String id) async {
    final appointments = getAppointments();
    final index = appointments.indexWhere((a) => a.id == id);
    if (index >= 0) {
      appointments[index] = Appointment(
        id: appointments[index].id,
        doctorName: appointments[index].doctorName,
        specialty: appointments[index].specialty,
        date: appointments[index].date,
        time: appointments[index].time,
        location: appointments[index].location,
        notes: appointments[index].notes,
        isCompleted: true,
        aiSuggestedQuestions: appointments[index].aiSuggestedQuestions,
        followUpNeeded: appointments[index].followUpNeeded,
      );
      await box.put(_appointmentsKey, appointments);
    }
  }

  List<Appointment> getUpcomingAppointments() {
    return getAppointments()
      .where((a) => !a.isPast && !a.isCompleted)
      .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  List<Appointment> getPastAppointments() {
    return getAppointments()
      .where((a) => a.isPast || a.isCompleted)
      .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  // Medications
  List<Medication> getMedications() {
    return box.get(_medicationsKey, defaultValue: <Medication>[])?.cast<Medication>() ?? [];
  }

  Future<void> saveMedication(Medication medication) async {
    final medications = getMedications();
    final index = medications.indexWhere((m) => m.id == medication.id);
    
    if (index >= 0) {
      medications[index] = medication;
    } else {
      medications.add(medication);
    }
    
    await box.put(_medicationsKey, medications);
  }

  Future<void> recordMedicationTaken(String id) async {
    final medications = getMedications();
    final index = medications.indexWhere((m) => m.id == id);
    if (index >= 0) {
      final med = medications[index];
      medications[index] = Medication(
        id: med.id,
        name: med.name,
        dosage: med.dosage,
        frequency: med.frequency,
        instructions: med.instructions,
        refillsRemaining: med.refillsRemaining,
        lastRefillDate: med.lastRefillDate,
        isActive: med.isActive,
        takenHistory: [...med.takenHistory, DateTime.now()],
        prescribedBy: med.prescribedBy,
        pharmacy: med.pharmacy,
        nextRefillDate: med.nextRefillDate,
      );
      await box.put(_medicationsKey, medications);
    }
  }

  List<Medication> getMedicationsNeedingRefill() {
    return getMedications().where((m) => m.needsRefill).toList();
  }

  // Documents
  List<HealthDocument> getDocuments() {
    return box.get(_documentsKey, defaultValue: <HealthDocument>[])?.cast<HealthDocument>() ?? [];
  }

  Future<void> saveDocument(HealthDocument document) async {
    final documents = getDocuments();
    final index = documents.indexWhere((d) => d.id == document.id);
    
    if (index >= 0) {
      documents[index] = document;
    } else {
      documents.add(document);
    }
    
    await box.put(_documentsKey, documents);
  }

  // Emergency Contacts
  List<EmergencyContact> getEmergencyContacts() {
    return box.get(_emergencyContactsKey, defaultValue: <EmergencyContact>[])?.cast<EmergencyContact>() ?? [];
  }

  Future<void> saveEmergencyContact(EmergencyContact contact) async {
    final contacts = getEmergencyContacts();
    final index = contacts.indexWhere((c) => c.id == contact.id);
    
    if (index >= 0) {
      contacts[index] = contact;
    } else {
      contacts.add(contact);
    }
    
    await box.put(_emergencyContactsKey, contacts);
  }

  EmergencyContact? getPrimaryEmergencyContact() {
    return getEmergencyContacts().firstWhere(
      (c) => c.isPrimary,
      orElse: () => getEmergencyContacts().isNotEmpty ? getEmergencyContacts().first : null as EmergencyContact,
    );
  }

  // Metric History
  List<HealthMetric> getMetricHistory() {
    return box.get(_metricHistoryKey, defaultValue: <HealthMetric>[])?.cast<HealthMetric>() ?? [];
  }

  Future<void> addMetric(HealthMetric metric) async {
    final history = getMetricHistory()..add(metric);
    await box.put(_metricHistoryKey, history);
  }

  List<HealthMetric> getMetricsByType(String type, {int limit = 30}) {
    return getMetricHistory()
      .where((m) => m.type == type)
      .toList()
      ..sort((a, b) => b.date.compareTo(a.date))
      ..take(limit).toList();
  }

  // Data for AI analysis
  Map<String, dynamic> getDataForAI() {
    return {
      'policies': getPolicies().map((p) => p.toJson()).toList(),
      'upcomingAppointments': getUpcomingAppointments().take(5).map((a) => a.toJson()).toList(),
      'activeMedications': getMedications().where((m) => m.isActive).map((m) => m.toJson()).toList(),
      'medicationsNeedingRefill': getMedicationsNeedingRefill().length,
      'metricHistory': getMetricHistory().take(30).map((m) => m.toJson()).toList(),
    };
  }

  Future<void> clearAll() async {
    await box.clear();
  }
}
