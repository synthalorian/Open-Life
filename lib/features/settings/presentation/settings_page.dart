import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/neon_card.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static const String githubUrl = 'https://github.com/synthalorian/OpenLife';
  static const String buyMeCoffeeUrl = 'https://www.buymeacoffee.com/synthalorian';

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open link: $url'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => AppColors.sunsetGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Text(
                      'Settings',
                      style: AppTextStyles.h1.copyWith(color: Colors.white),
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                  const SizedBox(height: 8),
                  Text(
                    'Support & Information',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                ],
              ),
            ),
          ),

          // Support Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Support Development',
                    style: AppTextStyles.h4,
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 16),

                  // Buy Me a Coffee Button
                  _buildSupportCard(
                    context: context,
                    icon: PhosphorIcons.coffee(),
                    iconColor: AppColors.sunsetOrange,
                    title: 'Buy Me a Coffee',
                    subtitle: 'Support development with a donation',
                    gradient: LinearGradient(
                      colors: [AppColors.sunsetOrange, AppColors.neonPink],
                    ),
                    onTap: () => _launchUrl(context, buyMeCoffeeUrl),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

                  const SizedBox(height: 12),

                  // Open Source Button
                  _buildSupportCard(
                    context: context,
                    icon: PhosphorIcons.githubLogo(),
                    iconColor: AppColors.textPrimary,
                    title: 'Open Source',
                    subtitle: 'View source code on GitHub',
                    gradient: LinearGradient(
                      colors: [AppColors.electricPurple, AppColors.neonPink],
                    ),
                    onTap: () => _launchUrl(context, githubUrl),
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
                ],
              ),
            ),
          ),

          // About Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: AppTextStyles.h4,
                  ).animate().fadeIn(delay: 600.ms),
                  const SizedBox(height: 16),

                  NeonCard(
                    glowColor: AppColors.cyan,
                    child: Column(
                      children: [
                        _buildAboutRow(
                          icon: PhosphorIcons.info(),
                          label: 'Version',
                          value: '1.0.0',
                        ),
                        const Divider(color: AppColors.electricPurpleDark, height: 32),
                        _buildAboutRow(
                          icon: PhosphorIcons.code(),
                          label: 'Built with',
                          value: 'Flutter & ❤️',
                        ),
                        const Divider(color: AppColors.electricPurpleDark, height: 32),
                        _buildAboutRow(
                          icon: PhosphorIcons.paintBrush(),
                          label: 'Theme',
                          value: 'Synthwave',
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1),
                ],
              ),
            ),
          ),

          // App Description
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              child: NeonCard(
                gradient: LinearGradient(
                  colors: [
                    AppColors.neonPink.withOpacity(0.2),
                    AppColors.electricPurple.withOpacity(0.2),
                  ],
                ),
                glowColor: AppColors.neonPink,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: AppColors.sunsetGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        PhosphorIconsFill.heart,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Open Life',
                      style: AppTextStyles.h4,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'The ultimate AI-powered life management app with synthwave aesthetics. '
                      '100% free and open source.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildFeatureChip('Fitness', AppColors.fitnessPrimary),
                        _buildFeatureChip('Finance', AppColors.financePrimary),
                        _buildFeatureChip('Health', AppColors.assurancePrimary),
                        _buildFeatureChip('AI', AppColors.cyan),
                        _buildFeatureChip('Free', AppColors.neonGreen),
                        _buildFeatureChip('Open Source', AppColors.electricPurple),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return NeonCard(
      glowColor: iconColor,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: iconColor.withOpacity(0.4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h5,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.backgroundCardLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              PhosphorIcons.arrowSquareOut(),
              color: iconColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.cyan, size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: color),
      ),
    );
  }
}
