import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class SynthwaveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? leading;

  const SynthwaveAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = false,
    this.leading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.backgroundDarker,
            AppColors.backgroundDark,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.electricPurpleDark,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: leading ?? (showBackButton ? const BackButton() : null),
        title: ShaderMask(
          shaderCallback: (bounds) => AppColors.sunsetGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            title,
            style: AppTextStyles.h4.copyWith(color: Colors.white),
          ),
        ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
        actions: actions,
      ),
    );
  }
}

class SynthwaveSliverAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final double expandedHeight;
  final Widget? flexibleSpace;

  const SynthwaveSliverAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.expandedHeight = 120,
    this.flexibleSpace,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.backgroundDarker,
      flexibleSpace: flexibleSpace ??
          FlexibleSpaceBar(
            title: ShaderMask(
              shaderCallback: (bounds) => AppColors.sunsetGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                title,
                style: AppTextStyles.h5.copyWith(color: Colors.white),
              ),
            ),
            titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
          ),
      actions: actions,
    );
  }
}
