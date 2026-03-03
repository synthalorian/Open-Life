import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/neon_card.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../providers/assurance_provider.dart';

class AssurancePage extends ConsumerStatefulWidget {
  const AssurancePage({super.key});

  @override
  ConsumerState<AssurancePage> createState() => _AssurancePageState();
}

class _AssurancePageState extends ConsumerState<AssurancePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assuranceState = ref.watch(assuranceProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.backgroundDarker,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.assurancePrimary.withOpacity(0.3),
                      AppColors.backgroundDarker,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => AppColors.assuranceGradient.createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: Text(
                            'Health & Assurance',
                            style: AppTextStyles.h1.copyWith(color: Colors.white),
                          ),
                        ).animate().fadeIn(),
                        const SizedBox(height: 8),
                        Text(
                          'AI-powered health & insurance management',
                          style: AppTextStyles.bodyMedium,
                        ).animate().fadeIn(delay: 200.ms),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.assurancePrimary,
              labelColor: AppColors.assurancePrimary,
              unselectedLabelColor: AppColors.textMuted,
              tabs: const [
                Tab(icon: Icon(PhosphorIcons.houseLine)),
                Tab(icon: Icon(PhosphorIcons.shieldCheck)),
                Tab(icon: Icon(PhosphorIcons.pill)),
                Tab(icon: Icon(PhosphorIcons.sparkle)),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(assuranceState),
            _buildInsuranceTab(),
            _buildMedicalTab(),
            _buildAIAssistantTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab(AssuranceState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Actions
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  'Find Doctor',
                  PhosphorIcons.magnifyingGlass,
                  AppColors.assurancePrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Book Appointment',
                  PhosphorIcons.calendarPlus,
                  AppColors.electricPurple,
                ),
              ),
            ],
          ).animate().fadeIn().slideY(begin: 0.1),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  'View Coverage',
                  PhosphorIcons.shieldCheck,
                  AppColors.financePrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Emergency',
                  PhosphorIcons.firstAid,
                  AppColors.error,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),

          const SizedBox(height: 24),

          // Upcoming Appointments
          Text('Upcoming Appointments', style: AppTextStyles.h4).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 16),
          ...state.upcomingAppointments.map((apt) => _buildAppointmentCard(apt)),

          const SizedBox(height: 24),

          // Health Metrics
          Text('Health Metrics', style: AppTextStyles.h4).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: NeonStatCard(
                  title: 'Blood Pressure',
                  value: '${state.bloodPressureSystolic}/${state.bloodPressureDiastolic}',
                  subtitle: 'mmHg',
                  icon: PhosphorIcons.heartbeat,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeonStatCard(
                  title: 'Weight',
                  value: '${state.weight.toStringAsFixed(1)}',
                  subtitle: 'lbs',
                  icon: PhosphorIcons.scales,
                  color: AppColors.assurancePrimary,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

          // AI Health Insight
          const SizedBox(height: 24),
          _buildAIInsight(state.aiInsight).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }

  Widget _buildInsuranceTab() {
    final assuranceState = ref.watch(assuranceProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Policies', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          ...assuranceState.insurancePolicies.map((policy) => _buildPolicyCard(policy)),
          const SizedBox(height: 24),
          GradientButton(
            text: 'Add Policy',
            icon: PhosphorIcons.plus,
            gradient: AppColors.assuranceGradient,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalTab() {
    final assuranceState = ref.watch(assuranceProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Medications', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          ...assuranceState.medications.map((med) => _buildMedicationCard(med)),
          const SizedBox(height: 24),
          Text('Medical Documents', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          _buildDocumentCard('Lab Results - Jan 2026', PhosphorIcons.fileText),
          _buildDocumentCard('Annual Physical', PhosphorIcons.firstAid),
          _buildDocumentCard('Vaccination Records', PhosphorIcons.syringe),
          const SizedBox(height: 24),
          GradientButton(
            text: 'Upload Document',
            icon: PhosphorIcons.uploadSimple,
            gradient: AppColors.assuranceGradient,
          ),
        ],
      ),
    );
  }

  Widget _buildAIAssistantTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NeonCard(
            gradient: LinearGradient(
              colors: [
                AppColors.assurancePrimary.withOpacity(0.2),
                AppColors.cyan.withOpacity(0.2),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: AppColors.assuranceGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(PhosphorIcons.brain, size: 32, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text('AI Health Assistant', style: AppTextStyles.h3),
                const SizedBox(height: 8),
                Text(
                  'Get help understanding your coverage, managing appointments, and staying healthy',
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                GradientButton(
                  text: 'Start Chat',
                  icon: PhosphorIcons.chatCircle,
                  gradient: AppColors.assuranceGradient,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Quick Questions', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          _buildQuickQuestion('What does my insurance cover?'),
          _buildQuickQuestion('When is my next appointment?'),
          _buildQuickQuestion('Should I get a second opinion?'),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color) {
    return NeonCard(
      glowColor: color,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(title, style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment apt) {
    return NeonCard(
      margin: const EdgeInsets.only(bottom: 12),
      glowColor: AppColors.assurancePrimary,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.assurancePrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(PhosphorIcons.calendarCheck, color: AppColors.assurancePrimary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(apt.doctorName, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                Text(apt.specialty, style: AppTextStyles.bodySmall),
                const SizedBox(height: 4),
                Text('${apt.date} at ${apt.time}', style: AppTextStyles.caption),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.assurancePrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.assurancePrimary.withOpacity(0.5)),
            ),
            child: Text(
              apt.daysUntil == 0 ? 'Today' : 'In ${apt.daysUntil} days',
              style: AppTextStyles.caption.copyWith(color: AppColors.assurancePrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyCard(InsurancePolicy policy) {
    return NeonCard(
      margin: const EdgeInsets.only(bottom: 12),
      glowColor: policy.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: policy.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(policy.icon, color: policy.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(policy.name, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                    Text(policy.provider, style: AppTextStyles.caption),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Active', style: AppTextStyles.caption.copyWith(color: AppColors.success)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Policy #', style: AppTextStyles.caption),
                    Text(policy.policyNumber, style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expires', style: AppTextStyles.caption),
                    Text(policy.expiryDate, style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Coverage', style: AppTextStyles.caption),
                    Text('\$${policy.coverageLimit.toStringAsFixed(0)}', style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(Medication med) {
    return NeonCard(
      margin: const EdgeInsets.only(bottom: 12),
      glowColor: AppColors.cyan,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cyan.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(PhosphorIcons.pill, color: AppColors.cyan, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(med.name, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                Text('${med.dosage} • ${med.frequency}', style: AppTextStyles.caption),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: med.refillsLeft > 0 ? AppColors.success.withOpacity(0.2) : AppColors.warning.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              med.refillsLeft > 0 ? '${med.refillsLeft} refills' : 'No refills',
              style: AppTextStyles.caption.copyWith(
                color: med.refillsLeft > 0 ? AppColors.success : AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(String title, IconData icon) {
    return NeonCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textMuted),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: AppTextStyles.bodyMedium)),
          const Icon(PhosphorIcons.arrowRight, color: AppColors.textMuted, size: 20),
        ],
      ),
    );
  }

  Widget _buildAIInsight(String insight) {
    return NeonCard(
      gradient: LinearGradient(
        colors: [
          AppColors.assurancePrimary.withOpacity(0.2),
          AppColors.cyan.withOpacity(0.2),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.assurancePrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(PhosphorIcons.sparkle, color: AppColors.assurancePrimary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Health Insight', style: AppTextStyles.h5.copyWith(color: AppColors.assurancePrimary)),
                const SizedBox(height: 4),
                Text(insight, style: AppTextStyles.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: NeonCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(child: Text(question, style: AppTextStyles.bodyMedium)),
            const Icon(PhosphorIcons.caretRight, color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}
