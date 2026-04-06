import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_text_styles.dart';
import 'core/theme/synthwave_theme.dart';

// ==================== COMPREHENSIVE STATE PROVIDERS ====================

// FITNESS STATE
final stepCountProvider = StateProvider<int>((ref) => 7243);
final stepGoalProvider = StateProvider<int>((ref) => 10000);
final workoutsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);
final mealsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);
final waterIntakeProvider = StateProvider<int>((ref) => 0);
final bodyMeasurementsProvider = StateProvider<Map<String, double>>((ref) => {
  'weight': 175.5, 'chest': 40.0, 'waist': 32.0, 'hips': 38.0, 'arms': 14.0, 'thighs': 22.0,
});
final progressPhotosProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);
final fitnessGoalsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'id': '1', 'name': 'Lose 10 lbs', 'target': 10.0, 'current': 5.0, 'type': 'weight'},
  {'id': '2', 'name': 'Run 5k', 'target': 5.0, 'current': 2.0, 'type': 'distance'},
]);

// FINANCE STATE
final balanceProvider = StateProvider<double>((ref) => 12847.50);
final incomeProvider = StateProvider<double>((ref) => 5200.00);
final expensesProvider = StateProvider<double>((ref) => 3420.00);
final transactionsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);
final budgetsProvider = StateProvider<Map<String, double>>((ref) => {
  'Food': 500.00, 'Transport': 200.00, 'Entertainment': 150.00, 'Utilities': 300.00, 'Shopping': 200.00, 'Health': 150.00,
});
final savingsGoalsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'id': '1', 'name': 'Emergency Fund', 'target': 5000.0, 'current': 2500.0, 'deadline': '2026-09-01'},
  {'id': '2', 'name': 'Vacation', 'target': 2000.0, 'current': 800.0, 'deadline': '2026-12-01'},
]);
final billsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'id': '1', 'name': 'Rent', 'amount': 1200.0, 'dueDate': '2026-03-15', 'paid': false},
  {'id': '2', 'name': 'Electric', 'amount': 150.0, 'dueDate': '2026-03-20', 'paid': false},
]);

// HEALTH STATE
final vitalsProvider = StateProvider<Map<String, dynamic>>((ref) => {
  'bpSystolic': 118, 'bpDiastolic': 76, 'weight': 175.5, 'heartRate': 72,
  'temperature': 98.6, 'oxygenSaturation': 98, 'bloodSugar': 95, 'sleepHours': 7.5,
});
final medicationsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'id': '1', 'name': 'Vitamin D', 'dosage': '1000 IU', 'frequency': 'Daily', 'times': ['8:00 AM']},
  {'id': '2', 'name': 'Omega-3', 'dosage': '1000mg', 'frequency': 'Daily', 'times': ['12:00 PM']},
]);
final appointmentsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'id': '1', 'doctor': 'Dr. Smith', 'specialty': 'General', 'date': '2026-03-20 10:00', 'location': 'City Medical Center'},
]);
final symptomsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);
final doctorsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'id': '1', 'name': 'Dr. Smith', 'specialty': 'General Practitioner', 'phone': '555-123-4567'},
]);
final insuranceProvider = StateProvider<Map<String, dynamic>>((ref) => {
  'provider': 'Blue Cross', 'policyNumber': 'BC-123456789', 'groupNumber': 'GRP-987654',
});
final emergencyContactsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'id': '1', 'name': 'Emergency Services', 'phone': '911', 'relationship': 'Emergency'},
  {'id': '2', 'name': 'Mom', 'phone': '555-987-6543', 'relationship': 'Mother'},
]);

// DIABETIC MONITORING
final glucoseReadingsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'id': '1', 'value': 95, 'timestamp': DateTime.now().subtract(const Duration(hours: 2)), 'type': 'Fasting', 'notes': 'Before breakfast'},
  {'id': '2', 'value': 142, 'timestamp': DateTime.now().subtract(const Duration(hours: 1)), 'type': 'Post-meal', 'notes': '2 hours after lunch'},
]);
final insulinDosesProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'id': '1', 'type': 'Rapid-acting', 'units': 5, 'timestamp': DateTime.now().subtract(const Duration(hours: 3))},
  {'id': '2', 'type': 'Long-acting', 'units': 12, 'timestamp': DateTime.now().subtract(const Duration(hours: 8))},
]);
final carbIntakeProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);
final a1cReadingsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'id': '1', 'value': 6.2, 'date': DateTime.now().subtract(const Duration(days: 90)), 'notes': 'Good control'},
]);

// MENTAL STATE
final moodProvider = StateProvider<int>((ref) => 7);
final anxietyProvider = StateProvider<int>((ref) => 3);
final stressProvider = StateProvider<int>((ref) => 4);
final energyProvider = StateProvider<int>((ref) => 6);
final journalEntriesProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);
final gratitudeItemsProvider = StateProvider<List<String>>((ref) => []);

// AI STATE
final aiMessagesProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {'role': 'assistant', 'message': 'Welcome to Open Life! I can help with fitness, finance, health, and mental wellness. What would you like to explore?', 'timestamp': DateTime.now()},
]);
final isAiTypingProvider = StateProvider<bool>((ref) => false);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0A0A1A), systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const ProviderScope(child: OpenLifeApp()));
}

class OpenLifeApp extends StatelessWidget {
  const OpenLifeApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(title: 'Open Life', debugShowCheckedModeBanner: false, theme: SynthwaveTheme.dark, home: const MainScreen());
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [const DashboardScreen(), const FitnessScreen(), const FinanceScreen(), const HealthScreen(), const MentalScreen()];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.backgroundDarker, AppColors.backgroundDark])),
      child: _screens[_selectedIndex],
    ),
    floatingActionButton: const CompactAIButton(),
    bottomNavigationBar: NavigationBar(
      selectedIndex: _selectedIndex, onDestinationSelected: (i) => setState(() => _selectedIndex = i),
      backgroundColor: AppColors.backgroundDarker, indicatorColor: AppColors.neonPink.withOpacity(0.2),
      destinations: [
        NavigationDestination(icon: Icon(PhosphorIcons.house()), label: 'Home'),
        NavigationDestination(icon: Icon(PhosphorIcons.barbell()), label: 'Fitness'),
        NavigationDestination(icon: Icon(PhosphorIcons.wallet()), label: 'Finance'),
        NavigationDestination(icon: Icon(PhosphorIcons.heartbeat()), label: 'Health'),
        NavigationDestination(icon: Icon(PhosphorIcons.brain()), label: 'Mental'),
      ],
    ),
  );
}

class CompactAIButton extends ConsumerWidget {
  const CompactAIButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => FloatingActionButton.small(
    onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) => const AIChatSheet()),
    backgroundColor: AppColors.neonPink, child: Icon(PhosphorIcons.sparkle(), color: Colors.white, size: 20),
  ).animate().scale(delay: 500.ms, duration: 300.ms);
}

// ==================== AI CHAT ====================

class AIChatSheet extends ConsumerStatefulWidget {
  const AIChatSheet({super.key});
  @override
  ConsumerState<AIChatSheet> createState() => _AIChatSheetState();
}

class _AIChatSheetState extends ConsumerState<AIChatSheet> {
  final _controller = TextEditingController();
  
  Future<void> _sendMessage() async {
    final msg = _controller.text.trim();
    if (msg.isEmpty) return;
    _controller.clear();
    ref.read(aiMessagesProvider.notifier).update((s) => [...s, {'role': 'user', 'message': msg, 'timestamp': DateTime.now()}]);
    ref.read(isAiTypingProvider.notifier).state = true;
    await Future.delayed(const Duration(seconds: 1));
    ref.read(isAiTypingProvider.notifier).state = false;
    
    final lower = msg.toLowerCase();
    String response;
    if (lower.contains('step')) {
      response = 'You\'ve taken ${ref.read(stepCountProvider)} steps today. Keep moving!';
    } else if (lower.contains('money') || lower.contains('budget')) {
      response = 'Your balance is \$${ref.read(balanceProvider).toStringAsFixed(2)}. You\'re doing great!';
    } else if (lower.contains('mood')) {
      response = 'Your mood is ${ref.read(moodProvider)}/10. Remember to take care of yourself!';
    } else {
      response = 'I can help with fitness, finance, health, and mental wellness. What would you like to know?';
    }
    
    ref.read(aiMessagesProvider.notifier).update((s) => [...s, {'role': 'assistant', 'message': response, 'timestamp': DateTime.now()}]);
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(aiMessagesProvider);
    final isTyping = ref.watch(isAiTypingProvider);
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(color: AppColors.backgroundDark, borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), border: Border(top: BorderSide(color: AppColors.neonPink.withOpacity(0.5), width: 2))),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(gradient: AppColors.sunsetGradient, borderRadius: const BorderRadius.vertical(top: Radius.circular(22))),
          child: Row(children: [Icon(PhosphorIcons.sparkle(), color: Colors.white, size: 24), const SizedBox(width: 12), Expanded(child: Text('Open Life AI', style: AppTextStyles.h5.copyWith(color: Colors.white))), IconButton(onPressed: () => Navigator.pop(context), icon: Icon(PhosphorIcons.x(), color: Colors.white, size: 20))]),
        ),
        Expanded(child: ListView.builder(padding: const EdgeInsets.all(16), itemCount: messages.length + (isTyping ? 1 : 0), itemBuilder: (context, i) {
          if (i == messages.length && isTyping) return const Padding(padding: EdgeInsets.all(8), child: Text('Thinking...', style: TextStyle(color: AppColors.textMuted)));
          final msg = messages[i];
          final isUser = msg['role'] == 'user';
          return Align(alignment: isUser ? Alignment.centerRight : Alignment.centerLeft, child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(gradient: isUser ? AppColors.sunsetGradient : null, color: isUser ? null : AppColors.backgroundCard, borderRadius: BorderRadius.circular(16)), child: Text(msg['message'], style: AppTextStyles.bodyMedium.copyWith(color: isUser ? Colors.white : null))));
        })),
        Container(padding: const EdgeInsets.all(16), child: Row(children: [
          Expanded(child: TextField(controller: _controller, style: AppTextStyles.bodyMedium, decoration: InputDecoration(hintText: 'Ask me anything...', filled: true, fillColor: AppColors.backgroundDarker, border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)), onSubmitted: (_) => _sendMessage())),
          const SizedBox(width: 8),
          FloatingActionButton.small(onPressed: _sendMessage, backgroundColor: AppColors.neonPink, child: Icon(PhosphorIcons.paperPlaneRight(), color: Colors.white, size: 20)),
        ])),
      ]),
    );
  }
}

// ==================== DASHBOARD ====================

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fitness = ref.watch(stepCountProvider);
    final stepGoal = ref.watch(stepGoalProvider);
    final balance = ref.watch(balanceProvider);
    final mood = ref.watch(moodProvider);
    final vitals = ref.watch(vitalsProvider);
    final water = ref.watch(waterIntakeProvider);
    
    return SafeArea(child: CustomScrollView(slivers: [SliverToBoxAdapter(child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: ShaderMask(shaderCallback: (b) => AppColors.sunsetGradient.createShader(b), child: Text('Open Life', style: AppTextStyles.h1.copyWith(color: Colors.white)))),
          IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.gear(), color: AppColors.textMuted)),
        ]),
        Text(DateFormat('EEEE, MMMM d').format(DateTime.now()), style: AppTextStyles.bodyMedium),
        const SizedBox(height: 24),
        
        // Wellness Score
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.neonPink.withOpacity(0.3), AppColors.backgroundCard]), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.neonPink.withOpacity(0.5))),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Daily Wellness Score', style: AppTextStyles.h5.copyWith(color: AppColors.neonPink)),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: Text('78%', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.success, fontWeight: FontWeight.bold))),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              _buildMetric('Fitness', (fitness / stepGoal * 100).round(), AppColors.fitnessPrimary),
              _buildMetric('Mood', mood * 10, AppColors.neonPink),
              _buildMetric('Sleep', (vitals['sleepHours'] / 8 * 100).round(), AppColors.electricPurple),
              _buildMetric('Finance', balance > 5000 ? 100 : (balance / 5000 * 100).round(), AppColors.financePrimary),
            ]),
          ]),
        ),
        const SizedBox(height: 24),
        
        // Quick Stats
        Row(children: [
          Expanded(child: _buildQuickStat('Steps', '$fitness', '/$stepGoal', PhosphorIcons.footprints(), AppColors.fitnessPrimary, () => _showStepsDialog(context, ref))),
          const SizedBox(width: 12),
          Expanded(child: _buildQuickStat('Water', '$water', 'cups', PhosphorIcons.drop(), AppColors.cyan, () => ref.read(waterIntakeProvider.notifier).state++)),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _buildQuickStat('Balance', '\$${balance.toStringAsFixed(0)}', 'available', PhosphorIcons.wallet(), AppColors.financePrimary, () {})),
          const SizedBox(width: 12),
          Expanded(child: _buildQuickStat('Mood', '$mood', '/10', PhosphorIcons.smiley(), AppColors.neonPink, () {})),
        ]),
      ]),
    ))]));
  }
  
  Widget _buildMetric(String label, int pct, Color color) => Expanded(child: Column(children: [
    CircularProgressIndicator(value: pct / 100, strokeWidth: 6, backgroundColor: AppColors.backgroundDarker, valueColor: AlwaysStoppedAnimation(color)),
    const SizedBox(height: 8), Text(label, style: AppTextStyles.caption.copyWith(color: color)), Text('$pct%', style: AppTextStyles.bodySmall.copyWith(color: color)),
  ]));
  
  Widget _buildQuickStat(String title, String value, String subtitle, IconData icon, Color color, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.3))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 16)), const SizedBox(width: 6), Text(title, style: AppTextStyles.bodySmall)]),
        const SizedBox(height: 8), Text(value, style: AppTextStyles.h3.copyWith(color: color)), Text(subtitle, style: AppTextStyles.caption),
      ]),
    ),
  );
  
  void _showStepsDialog(BuildContext context, WidgetRef ref) {
    final ctrl = TextEditingController();
    showDialog(context: context, builder: (_) => AlertDialog(
      backgroundColor: AppColors.backgroundCard,
      title: Text('Add Steps', style: AppTextStyles.h4),
      content: TextField(controller: ctrl, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: 'Number of steps', filled: true, fillColor: AppColors.backgroundDarker, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: AppColors.textMuted))),
        ElevatedButton(onPressed: () { ref.read(stepCountProvider.notifier).state += int.tryParse(ctrl.text) ?? 0; Navigator.pop(context); }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.fitnessPrimary), child: const Text('Add')),
      ],
    ));
  }
}

// ==================== FITNESS SCREEN ====================

class FitnessScreen extends ConsumerWidget {
  const FitnessScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(stepCountProvider);
    final stepGoal = ref.watch(stepGoalProvider);
    final workouts = ref.watch(workoutsProvider);
    ref.watch(mealsProvider);
    final water = ref.watch(waterIntakeProvider);
    final measurements = ref.watch(bodyMeasurementsProvider);
    final goals = ref.watch(fitnessGoalsProvider);
    
    return SafeArea(child: CustomScrollView(slivers: [SliverToBoxAdapter(child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Fitness', style: AppTextStyles.h1),
        Text('Activity, workouts, nutrition & measurements', style: AppTextStyles.bodyMedium),
        const SizedBox(height: 24),
        
        // Steps Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: AppColors.fitnessGradient, borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Steps Today', style: AppTextStyles.h4.copyWith(color: Colors.white)), Icon(PhosphorIcons.footprints(), color: Colors.white, size: 32)]),
            const SizedBox(height: 20),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('$steps', style: AppTextStyles.statLarge.copyWith(color: Colors.white, fontSize: 48)), const SizedBox(width: 8), Text('/ $stepGoal', style: AppTextStyles.bodyLarge.copyWith(color: Colors.white70))]),
            const SizedBox(height: 16),
            LinearProgressIndicator(value: (steps / stepGoal).clamp(0, 1), backgroundColor: Colors.white24, valueColor: const AlwaysStoppedAnimation(Colors.white), borderRadius: BorderRadius.circular(8), minHeight: 12),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildMiniStat('${(steps * 0.04).round()}', 'cal', PhosphorIcons.fire()),
              _buildMiniStat('${(steps / 2000).round()}', 'km', PhosphorIcons.mapPin()),
              _buildMiniStat('45', 'min', PhosphorIcons.timer()),
            ]),
          ]),
        ),
        const SizedBox(height: 24),
        
        // Water Tracker
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.cyan.withOpacity(0.3))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Water Intake', style: AppTextStyles.h5.copyWith(color: AppColors.cyan)), Text('$water / 8 cups', style: AppTextStyles.bodyMedium)]),
            const SizedBox(height: 12),
            Row(children: List.generate(8, (i) => Expanded(child: GestureDetector(
              onTap: () => ref.read(waterIntakeProvider.notifier).state = i + 1,
              child: Container(height: 40, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: BoxDecoration(color: i < water ? AppColors.cyan.withOpacity(0.6) : AppColors.backgroundDarker, borderRadius: BorderRadius.circular(4)), child: Icon(PhosphorIcons.drop(), color: i < water ? Colors.white : AppColors.textMuted, size: 16)),
            )))),
          ]),
        ),
        const SizedBox(height: 24),
        
        // Body Measurements
        Text('Body Measurements', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            Row(children: [
              _buildMeasurement('Weight', '${measurements['weight']}', 'lbs'),
              _buildMeasurement('Chest', '${measurements['chest']}', 'in'),
              _buildMeasurement('Waist', '${measurements['waist']}', 'in'),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              _buildMeasurement('Hips', '${measurements['hips']}', 'in'),
              _buildMeasurement('Arms', '${measurements['arms']}', 'in'),
              _buildMeasurement('Thighs', '${measurements['thighs']}', 'in'),
            ]),
          ]),
        ),
        const SizedBox(height: 24),
        
        // Fitness Goals
        Text('Fitness Goals', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        ...goals.map((g) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(g['name'], style: AppTextStyles.bodyMedium), Text('${g['current']}/${g['target']}', style: AppTextStyles.caption)]),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: (g['current'] / g['target']).clamp(0, 1), backgroundColor: AppColors.backgroundDarker, valueColor: AlwaysStoppedAnimation(AppColors.fitnessPrimary), borderRadius: BorderRadius.circular(4), minHeight: 8),
          ]),
        )),
        const SizedBox(height: 24),
        
        // Quick Actions
        Text('Quick Actions', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 12, children: [
          _buildActionChip('Log Workout', PhosphorIcons.barbell(), AppColors.fitnessPrimary, () {}),
          _buildActionChip('Log Meal', PhosphorIcons.forkKnife(), AppColors.sunsetOrange, () {}),
          _buildActionChip('Progress Photo', PhosphorIcons.camera(), AppColors.cyan, () {}),
          _buildActionChip('Update Measurements', PhosphorIcons.ruler(), AppColors.electricPurple, () {}),
        ]),
        const SizedBox(height: 24),
        
        // Recent Workouts
        if (workouts.isNotEmpty) ...[Text('Recent Workouts', style: AppTextStyles.h4), const SizedBox(height: 12), ...workouts.take(5).map((w) => ListTile(
          leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.fitnessPrimary.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Icon(PhosphorIcons.barbell(), color: AppColors.fitnessPrimary)),
          title: Text(w['name'] ?? 'Workout', style: AppTextStyles.bodyMedium),
          subtitle: Text('${w['duration']} min • ${w['calories']} cal', style: AppTextStyles.caption),
          trailing: Text(DateFormat('h:mm a').format(DateTime.now()), style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
        ))],
      ]),
    ))]));
  }
  
  Widget _buildMiniStat(String value, String label, IconData icon) => Column(children: [Icon(icon, color: Colors.white70, size: 20), const SizedBox(height: 4), Text(value, style: AppTextStyles.bodyLarge.copyWith(color: Colors.white)), Text(label, style: AppTextStyles.caption.copyWith(color: Colors.white70))]);
  
  Widget _buildMeasurement(String label, String value, String unit) => Expanded(child: Column(children: [
    Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
    const SizedBox(height: 4), Text(value, style: AppTextStyles.h5), Text(unit, style: AppTextStyles.caption),
  ]));
  
  Widget _buildActionChip(String label, IconData icon, Color color, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: color, size: 20), const SizedBox(width: 8), Text(label, style: AppTextStyles.bodyMedium)])),
  );
}

// ==================== FINANCE SCREEN ====================

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(balanceProvider);
    final income = ref.watch(incomeProvider);
    final expenses = ref.watch(expensesProvider);
    ref.watch(transactionsProvider);
    final budgets = ref.watch(budgetsProvider);
    final goals = ref.watch(savingsGoalsProvider);
    final bills = ref.watch(billsProvider);
    final savings = income - expenses;
    
    return SafeArea(child: CustomScrollView(slivers: [SliverToBoxAdapter(child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Finance', style: AppTextStyles.h1),
        Text('Budgets, savings & spending', style: AppTextStyles.bodyMedium),
        const SizedBox(height: 24),
        
        // Balance Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: AppColors.financeGradient, borderRadius: BorderRadius.circular(20)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Total Balance', style: AppTextStyles.h4.copyWith(color: Colors.white70)), Icon(PhosphorIcons.wallet(), color: Colors.white, size: 28)]),
            const SizedBox(height: 8), Text('\$${balance.toStringAsFixed(2)}', style: AppTextStyles.statLarge.copyWith(color: Colors.white)),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Income', style: AppTextStyles.caption.copyWith(color: Colors.white70)), Text('\$${income.toStringAsFixed(0)}', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.success))])),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Expenses', style: AppTextStyles.caption.copyWith(color: Colors.white70)), Text('\$${expenses.toStringAsFixed(0)}', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.error))])),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Savings', style: AppTextStyles.caption.copyWith(color: Colors.white70)), Text('${(savings / income * 100).toStringAsFixed(0)}%', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.cyan))])),
            ]),
          ]),
        ),
        const SizedBox(height: 24),
        
        // Budget Progress
        Text('Monthly Budgets', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        ...budgets.entries.map((e) => _buildBudgetItem(e.key, e.value, expenses * 0.15)),
        const SizedBox(height: 24),
        
        // Savings Goals
        Text('Savings Goals', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        ...goals.map((g) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(g['name'], style: AppTextStyles.bodyMedium), Text('\$${g['current'].toStringAsFixed(0)} / \$${g['target'].toStringAsFixed(0)}', style: AppTextStyles.caption)]),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: (g['current'] / g['target']).clamp(0, 1), backgroundColor: AppColors.backgroundDarker, valueColor: AlwaysStoppedAnimation(AppColors.financePrimary), borderRadius: BorderRadius.circular(4), minHeight: 8),
            const SizedBox(height: 4), Text('Target: ${g['deadline']}', style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
          ]),
        )),
        const SizedBox(height: 24),
        
        // Bills
        Text('Upcoming Bills', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        ...bills.map((b) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: b['paid'] ? AppColors.success.withOpacity(0.2) : AppColors.warning.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Icon(b['paid'] ? PhosphorIcons.checkCircle() : PhosphorIcons.warningCircle(), color: b['paid'] ? AppColors.success : AppColors.warning)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(b['name'], style: AppTextStyles.bodyMedium), Text('Due: ${b['dueDate']}', style: AppTextStyles.caption)])),
            Text('\$${b['amount'].toStringAsFixed(0)}', style: AppTextStyles.bodyLarge.copyWith(color: b['paid'] ? AppColors.success : AppColors.textPrimary)),
          ]),
        )),
        const SizedBox(height: 24),
        
        // Quick Actions
        Text('Quick Actions', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 12, children: [
          _buildActionChip('Add Income', PhosphorIcons.plus(), AppColors.success, () {}),
          _buildActionChip('Add Expense', PhosphorIcons.minus(), AppColors.error, () {}),
          _buildActionChip('Transfer', PhosphorIcons.arrowsLeftRight(), AppColors.cyan, () {}),
          _buildActionChip('Add Bill', PhosphorIcons.receipt(), AppColors.warning, () {}),
        ]),
      ]),
    ))]));
  }
  
  Widget _buildBudgetItem(String category, double budget, double spent) {
    final pct = (spent / budget).clamp(0.0, 1.0);
    final color = pct > 0.9 ? AppColors.error : pct > 0.7 ? AppColors.warning : AppColors.success;
    return Container(
      margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(category, style: AppTextStyles.bodyMedium), Text('\$${spent.toStringAsFixed(0)} / \$${budget.toStringAsFixed(0)}', style: AppTextStyles.caption)]),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: pct, backgroundColor: AppColors.backgroundDarker, valueColor: AlwaysStoppedAnimation(color), borderRadius: BorderRadius.circular(4), minHeight: 8),
      ]),
    );
  }
  
  Widget _buildActionChip(String label, IconData icon, Color color, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: color, size: 20), const SizedBox(width: 8), Text(label, style: AppTextStyles.bodyMedium)])),
  );
}

// ==================== HEALTH SCREEN ====================

class HealthScreen extends ConsumerWidget {
  const HealthScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vitals = ref.watch(vitalsProvider);
    final medications = ref.watch(medicationsProvider);
    final appointments = ref.watch(appointmentsProvider);
    ref.watch(symptomsProvider);
    final doctors = ref.watch(doctorsProvider);
    final insurance = ref.watch(insuranceProvider);
    final emergencyContacts = ref.watch(emergencyContactsProvider);
    
    return SafeArea(child: CustomScrollView(slivers: [SliverToBoxAdapter(child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Health', style: AppTextStyles.h1),
        Text('Medical records, appointments & vitals', style: AppTextStyles.bodyMedium),
        const SizedBox(height: 24),
        
        // Vitals Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: AppColors.assuranceGradient, borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Current Vitals', style: AppTextStyles.h4.copyWith(color: Colors.white)), Icon(PhosphorIcons.heartbeat(), color: Colors.white, size: 32)]),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: _buildVital('BP', '${vitals['bpSystolic']}/${vitals['bpDiastolic']}', 'mmHg')),
              Expanded(child: _buildVital('Heart Rate', '${vitals['heartRate']}', 'bpm')),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: _buildVital('Temperature', '${vitals['temperature']}', '°F')),
              Expanded(child: _buildVital('O2 Sat', '${vitals['oxygenSaturation']}', '%')),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: _buildVital('Blood Sugar', '${vitals['bloodSugar']}', 'mg/dL')),
              Expanded(child: _buildVital('Sleep', '${vitals['sleepHours']}', 'hours')),
            ]),
          ]),
        ),
        const SizedBox(height: 24),
        
        // Diabetic Monitoring Section
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.warning.withOpacity(0.3), AppColors.backgroundCard]),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.warning.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Diabetic Monitoring', style: AppTextStyles.h4.copyWith(color: AppColors.warning)),
                  Icon(PhosphorIcons.drop(), color: AppColors.warning, size: 28),
                ],
              ),
              const SizedBox(height: 16),
              
              // Current Glucose
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDarker,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: vitals['bloodSugar'] < 140 ? AppColors.success.withOpacity(0.2) : AppColors.error.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        PhosphorIcons.drop(),
                        color: vitals['bloodSugar'] < 140 ? AppColors.success : AppColors.error,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Current Blood Glucose', style: AppTextStyles.bodyMedium),
                          const SizedBox(height: 4),
                          Text('${vitals['bloodSugar']} mg/dL', style: AppTextStyles.h3.copyWith(
                            color: vitals['bloodSugar'] < 140 ? AppColors.success : AppColors.error,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // A1C
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundDarker,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('A1C', style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
                          Text('${ref.watch(a1cReadingsProvider).last['value']}%', style: AppTextStyles.h4.copyWith(color: AppColors.cyan)),
                          Text('Last: ${DateFormat('MMM d').format(ref.watch(a1cReadingsProvider).last['date'])}', style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundDarker,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Daily Average', style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
                          Text('118 mg/dL', style: AppTextStyles.h4.copyWith(color: AppColors.neonPink)),
                          Text('Last 24 hours', style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Recent Glucose Readings
              Text('Recent Readings', style: AppTextStyles.h5.copyWith(color: AppColors.warning)),
              const SizedBox(height: 8),
              ...ref.watch(glucoseReadingsProvider).take(3).map((reading) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDarker,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: reading['value'] < 140 ? AppColors.success : reading['value'] < 180 ? AppColors.warning : AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${reading['value']} mg/dL', style: AppTextStyles.bodyMedium),
                          Text('${reading['type']} • ${reading['notes']}', style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                    Text(DateFormat('h:mm a').format(reading['timestamp']), style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
                  ],
                ),
              )),
              const SizedBox(height: 16),
              
              // Insulin
              Text('Recent Insulin', style: AppTextStyles.h5.copyWith(color: AppColors.warning)),
              const SizedBox(height: 8),
              ...ref.watch(insulinDosesProvider).take(2).map((dose) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDarker,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(PhosphorIcons.syringe(), color: AppColors.electricPurple, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${dose['type']}', style: AppTextStyles.bodyMedium),
                          Text('${dose['units']} units', style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                    Text(DateFormat('h:mm a').format(dose['timestamp']), style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
                  ],
                ),
              )),
              const SizedBox(height: 16),
              
              // Diabetic Actions
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildDiabeticChip('Log Glucose', PhosphorIcons.drop(), () {}),
                  _buildDiabeticChip('Log Insulin', PhosphorIcons.syringe(), () {}),
                  _buildDiabeticChip('Log Carbs', PhosphorIcons.forkKnife(), () {}),
                  _buildDiabeticChip('A1C Test', PhosphorIcons.chartLine(), () {}),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // Medications
        Text('Medications', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        ...medications.map((m) => Container(
          margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.assurancePrimary.withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: Icon(PhosphorIcons.pill(), color: AppColors.assurancePrimary)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(m['name'], style: AppTextStyles.bodyMedium), Text('${m['dosage']} • ${m['frequency']}', style: AppTextStyles.caption)])),
            Text(m['times'].join(', '), style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
          ]),
        )),
        const SizedBox(height: 24),
        
        // Appointments
        Text('Upcoming Appointments', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        ...appointments.map((a) => Container(
          margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.cyan.withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: Icon(PhosphorIcons.calendar(), color: AppColors.cyan)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(a['doctor'], style: AppTextStyles.bodyMedium), Text('${a['specialty']} • ${a['date']}', style: AppTextStyles.caption)])),
          ]),
        )),
        const SizedBox(height: 24),
        
        // Doctors
        Text('My Doctors', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        ...doctors.map((d) => Container(
          margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.neonPink.withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: Icon(PhosphorIcons.user(), color: AppColors.neonPink)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(d['name'], style: AppTextStyles.bodyMedium), Text(d['specialty'], style: AppTextStyles.caption)])),
            IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.phone(), color: AppColors.success)),
          ]),
        )),
        const SizedBox(height: 24),
        
        // Insurance
        Text('Insurance Information', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Icon(PhosphorIcons.shield(), color: AppColors.success), const SizedBox(width: 12), Expanded(child: Text(insurance['provider'], style: AppTextStyles.bodyLarge))]),
            const SizedBox(height: 8),
            Text('Policy: ${insurance['policyNumber']}', style: AppTextStyles.bodyMedium),
            Text('Group: ${insurance['groupNumber']}', style: AppTextStyles.caption),
          ]),
        ),
        const SizedBox(height: 24),
        
        // Emergency Contacts
        Text('Emergency Contacts', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        ...emergencyContacts.map((e) => Container(
          margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.error.withOpacity(0.3))),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.error.withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: Icon(PhosphorIcons.warning(), color: AppColors.error)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(e['name'], style: AppTextStyles.bodyMedium), Text(e['relationship'], style: AppTextStyles.caption)])),
            IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.phone(), color: AppColors.success)),
          ]),
        )),
        const SizedBox(height: 24),
        
        // Quick Actions
        Text('Quick Actions', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 12, children: [
          _buildActionChip('Log Vitals', PhosphorIcons.gauge(), AppColors.assurancePrimary, () {}),
          _buildActionChip('Add Medication', PhosphorIcons.pill(), AppColors.warning, () {}),
          _buildActionChip('Schedule Appt', PhosphorIcons.calendar(), AppColors.cyan, () {}),
          _buildActionChip('Log Symptom', PhosphorIcons.pulse(), AppColors.error, () {}),
        ]),
      ]),
    ))]));
  }
  
  Widget _buildVital(String label, String value, String unit) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
    const SizedBox(height: 4), Text(value, style: AppTextStyles.h4.copyWith(color: Colors.white)), Text(unit, style: AppTextStyles.caption.copyWith(color: Colors.white60)),
  ]);
  
  Widget _buildDiabeticChip(String label, IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.warning.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.warning, size: 16),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.warning)),
        ],
      ),
    ),
  );
  
  Widget _buildActionChip(String label, IconData icon, Color color, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: color, size: 20), const SizedBox(width: 8), Text(label, style: AppTextStyles.bodyMedium)])),
  );
}

// ==================== MENTAL SCREEN ====================

class MentalScreen extends ConsumerStatefulWidget {
  const MentalScreen({super.key});
  @override
  ConsumerState<MentalScreen> createState() => _MentalScreenState();
}

class _MentalScreenState extends ConsumerState<MentalScreen> {
  @override
  Widget build(BuildContext context) {
    final mood = ref.watch(moodProvider);
    final anxiety = ref.watch(anxietyProvider);
    final stress = ref.watch(stressProvider);
    final energy = ref.watch(energyProvider);
    final gratitude = ref.watch(gratitudeItemsProvider);
    ref.watch(journalEntriesProvider);
    
    return SafeArea(child: CustomScrollView(slivers: [SliverToBoxAdapter(child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Mental Health', style: AppTextStyles.h1),
        Text('Track your mind & spirit', style: AppTextStyles.bodyMedium),
        const SizedBox(height: 24),
        
        // Daily Check-in
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.neonPink.withOpacity(0.6), AppColors.electricPurple.withOpacity(0.6)]), borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Text('Daily Check-in', style: AppTextStyles.h4.copyWith(color: Colors.white)),
            const SizedBox(height: 16),
            _buildSlider('Mood', mood, AppColors.success, (v) => ref.read(moodProvider.notifier).state = v.round()),
            _buildSlider('Anxiety', anxiety, AppColors.warning, (v) => ref.read(anxietyProvider.notifier).state = v.round()),
            _buildSlider('Stress', stress, AppColors.error, (v) => ref.read(stressProvider.notifier).state = v.round()),
            _buildSlider('Energy', energy, AppColors.cyan, (v) => ref.read(energyProvider.notifier).state = v.round()),
          ]),
        ),
        const SizedBox(height: 24),
        
        // Spiritual Practices
        Text('Spiritual Practices', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 12, children: [
          _buildPractice('Meditation', Icons.self_improvement, AppColors.cyan),
          _buildPractice('Gratitude', PhosphorIcons.heart(), AppColors.neonPink),
          _buildPractice('Journal', PhosphorIcons.notebook(), AppColors.electricPurple),
          _buildPractice('Prayer', Icons.church, AppColors.gold),
          _buildPractice('Breathing', PhosphorIcons.wind(), AppColors.success),
        ]),
        const SizedBox(height: 24),
        
        // Gratitude List
        if (gratitude.isNotEmpty) ...[Text('Gratitude List', style: AppTextStyles.h4), const SizedBox(height: 12), ...gratitude.take(5).map((g) => Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12)), child: Row(children: [Icon(PhosphorIcons.heart(), color: AppColors.neonPink, size: 18), const SizedBox(width: 12), Expanded(child: Text(g, style: AppTextStyles.bodyMedium))])))]
      ]),
    ))]));
  }
  
  Widget _buildSlider(String label, int value, Color color, Function(double) onChanged) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)), Text('$value/10', style: AppTextStyles.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold))]),
    Slider(value: value.toDouble(), min: 1, max: 10, divisions: 9, activeColor: color, inactiveColor: Colors.white24, onChanged: onChanged),
  ]);
  
  Widget _buildPractice(String label, IconData icon, Color color) => GestureDetector(
    onTap: () {},
    child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: color, size: 20), const SizedBox(width: 8), Text(label, style: AppTextStyles.bodyMedium)])),
  );
}