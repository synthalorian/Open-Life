import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class MentalHealthEntry {
  final DateTime date;
  final int moodRating; // 1-10
  final int anxietyLevel; // 1-10
  final int stressLevel; // 1-10
  final int energyLevel; // 1-10
  final int sleepQuality; // 1-10
  final String? journalEntry;
  final List<String> triggers;
  final List<String> copingStrategies;
  final bool hadTherapy;
  final String? therapyNotes;
  final bool tookMedication;

  MentalHealthEntry({
    required this.date,
    this.moodRating = 5,
    this.anxietyLevel = 5,
    this.stressLevel = 5,
    this.energyLevel = 5,
    this.sleepQuality = 5,
    this.journalEntry,
    this.triggers = const [],
    this.copingStrategies = const [],
    this.hadTherapy = false,
    this.therapyNotes,
    this.tookMedication = false,
  });
}

class SpiritualPractice {
  final DateTime date;
  final PracticeType type;
  final int durationMinutes;
  final String? notes;
  final int fulfillmentRating; // 1-10

  SpiritualPractice({
    required this.date,
    required this.type,
    this.durationMinutes = 0,
    this.notes,
    this.fulfillmentRating = 5,
  });
}

enum PracticeType {
  meditation,
  prayer,
  gratitude,
  mindfulness,
  reading,
  nature,
  yoga,
  breathing,
  reflection,
}

class HolisticHealthData {
  final List<MentalHealthEntry> mentalHealthHistory;
  final List<SpiritualPractice> spiritualPractices;
  final Map<String, dynamic> physicalMetrics;
  final DateTime lastUpdated;

  HolisticHealthData({
    this.mentalHealthHistory = const [],
    this.spiritualPractices = const [],
    this.physicalMetrics = const {},
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  // Mental health analytics
  double get avgMoodLast7Days {
    final last7 = mentalHealthHistory.where((e) => 
      e.date.isAfter(DateTime.now().subtract(const Duration(days: 7)))
    ).toList();
    if (last7.isEmpty) return 0;
    return last7.fold(0, (sum, e) => sum + e.moodRating) / last7.length;
  }

  double get avgAnxietyLast7Days {
    final last7 = mentalHealthHistory.where((e) => 
      e.date.isAfter(DateTime.now().subtract(const Duration(days: 7)))
    ).toList();
    if (last7.isEmpty) return 0;
    return last7.fold(0, (sum, e) => sum + e.anxietyLevel) / last7.length;
  }

  int get consecutiveDaysJournaled {
    if (mentalHealthHistory.isEmpty) return 0;
    final sorted = mentalHealthHistory..sort((a, b) => b.date.compareTo(a.date));
    int streak = 1;
    DateTime current = sorted.first.date;
    
    for (int i = 1; i < sorted.length; i++) {
      final previous = current.subtract(const Duration(days: 1));
      if (sorted[i].date.year == previous.year && 
          sorted[i].date.month == previous.month && 
          sorted[i].date.day == previous.day) {
        streak++;
        current = sorted[i].date;
      } else {
        break;
      }
    }
    return streak;
  }

  // Spiritual analytics
  int get totalMeditationMinutes {
    return spiritualPractices
      .where((p) => p.type == PracticeType.meditation)
      .fold(0, (sum, p) => sum + p.durationMinutes);
  }

  int get meditationStreak {
    // Calculate consecutive days with meditation
    final meditations = spiritualPractices
      .where((p) => p.type == PracticeType.meditation)
      .map((p) => DateTime(p.date.year, p.date.month, p.date.day))
      .toSet()
      .toList()
      ..sort((a, b) => b.compareTo(a));
    
    if (meditations.isEmpty) return 0;
    
    int streak = 1;
    for (int i = 1; i < meditations.length; i++) {
      final expected = meditations[i - 1].subtract(const Duration(days: 1));
      if (meditations[i].year == expected.year && 
          meditations[i].month == expected.month && 
          meditations[i].day == expected.day) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  Map<PracticeType, int> get practiceCounts {
    final counts = <PracticeType, int>{};
    for (final practice in spiritualPractices) {
      counts[practice.type] = (counts[practice.type] ?? 0) + 1;
    }
    return counts;
  }

  // Holistic wellness score (0-100)
  int get wellnessScore {
    int score = 50; // Base score
    
    // Mental health component (0-30)
    final avgMood = avgMoodLast7Days;
    if (avgMood > 0) {
      score += (avgMood / 10 * 15).round();
    }
    final avgAnxiety = avgAnxietyLast7Days;
    if (avgAnxiety > 0) {
      score += ((10 - avgAnxiety) / 10 * 15).round();
    }
    
    // Spiritual component (0-20)
    final meditationMinutes = totalMeditationMinutes;
    score += (meditationMinutes / 100 * 10).round().clamp(0, 10);
    score += (meditationStreak * 2).clamp(0, 10);
    
    // Physical component (0-30) - from fitness data
    // This would be populated from FitnessRepository
    
    // Consistency bonus (0-10)
    score += consecutiveDaysJournaled.clamp(0, 10);
    
    return score.clamp(0, 100);
  }
}

// Animated wellness score widget
class WellnessScoreCard extends StatelessWidget {
  final int score;
  final VoidCallback? onTap;

  const WellnessScoreCard({super.key, required this.score, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = _getScoreColor(score);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.3),
              AppColors.backgroundCard,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Wellness Score',
              style: AppTextStyles.h5.copyWith(color: color),
            ),
            const SizedBox(height: 12),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 12,
                    backgroundColor: AppColors.backgroundCardLight,
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
                Text(
                  '$score',
                  style: AppTextStyles.statLarge.copyWith(
                    color: color,
                    fontSize: 48,
                  ),
                ).animate().fadeIn(delay: 300.ms),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _getScoreLabel(score),
              style: AppTextStyles.bodyMedium.copyWith(color: color),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.cyan;
    if (score >= 40) return AppColors.warning;
    return AppColors.error;
  }

  String _getScoreLabel(int score) {
    if (score >= 80) return 'Thriving ✨';
    if (score >= 60) return 'Balanced 🌊';
    if (score >= 40) return 'Coping 💪';
    return 'Struggling ⚠️';
  }
}

// Mood tracker widget
class MoodTracker extends StatefulWidget {
  final Function(int mood, int anxiety, int stress)? onSubmit;

  const MoodTracker({super.key, this.onSubmit});

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  int _mood = 5;
  int _anxiety = 5;
  int _stress = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.electricPurple.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('How are you feeling?', style: AppTextStyles.h4),
          const SizedBox(height: 20),
          _buildSlider('Mood', _mood, (v) => setState(() => _mood = v)),
          _buildSlider('Anxiety', _anxiety, (v) => setState(() => _anxiety = v)),
          _buildSlider('Stress', _stress, (v) => setState(() => _stress = v)),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => widget.onSubmit?.call(_mood, _anxiety, _stress),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: AppColors.sunsetGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonPink.withOpacity(0.4),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Text(
                'Log Entry',
                textAlign: TextAlign.center,
                style: AppTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildSlider(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.bodyMedium),
            Text('$value/10', style: AppTextStyles.bodyMedium.copyWith(
              color: _getValueColor(value),
              fontWeight: FontWeight.bold,
            )),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: _getValueColor(value),
          inactiveColor: AppColors.backgroundCardLight,
          onChanged: (v) => onChanged(v.round()),
        ),
      ],
    );
  }

  Color _getValueColor(int value) {
    if (value <= 3) return AppColors.success;
    if (value <= 6) return AppColors.warning;
    return AppColors.error;
  }
}

// Spiritual practice widget
class SpiritualPracticeCard extends StatelessWidget {
  final PracticeType type;
  final int count;
  final int totalMinutes;
  final VoidCallback? onTap;

  const SpiritualPracticeCard({
    super.key,
    required this.type,
    required this.count,
    required this.totalMinutes,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icon = _getIcon(type);
    final label = _getLabel(type);
    final color = _getColor(type);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(label, style: AppTextStyles.bodySmall),
            const SizedBox(height: 4),
            Text(
              '$count sessions',
              style: AppTextStyles.caption.copyWith(color: color),
            ),
            Text(
              '${(totalMinutes / 60).toStringAsFixed(1)}h total',
              style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (type.index * 100).ms);
  }

  IconData _getIcon(PracticeType type) {
    return switch (type) {
      PracticeType.meditation => Icons.self_improvement,
      PracticeType.prayer => Icons.church,
      PracticeType.gratitude => Icons.favorite,
      PracticeType.mindfulness => Icons.psychology,
      PracticeType.reading => Icons.menu_book,
      PracticeType.nature => Icons.forest,
      PracticeType.yoga => Icons.sports_gymnastics,
      PracticeType.breathing => Icons.air,
      PracticeType.reflection => Icons.lightbulb,
    };
  }

  String _getLabel(PracticeType type) {
    return switch (type) {
      PracticeType.meditation => 'Meditation',
      PracticeType.prayer => 'Prayer',
      PracticeType.gratitude => 'Gratitude',
      PracticeType.mindfulness => 'Mindfulness',
      PracticeType.reading => 'Reading',
      PracticeType.nature => 'Nature',
      PracticeType.yoga => 'Yoga',
      PracticeType.breathing => 'Breathing',
      PracticeType.reflection => 'Reflection',
    };
  }

  Color _getColor(PracticeType type) {
    return switch (type) {
      PracticeType.meditation => AppColors.cyan,
      PracticeType.prayer => AppColors.gold,
      PracticeType.gratitude => AppColors.neonPink,
      PracticeType.mindfulness => AppColors.electricPurple,
      PracticeType.reading => AppColors.assurancePrimary,
      PracticeType.nature => AppColors.success,
      PracticeType.yoga => AppColors.fitnessPrimary,
      PracticeType.breathing => AppColors.cyanLight,
      PracticeType.reflection => AppColors.sunsetOrange,
    };
  }
}
