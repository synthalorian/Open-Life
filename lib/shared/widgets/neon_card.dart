import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class NeonCard extends StatefulWidget {
  final Widget child;
  final Gradient? gradient;
  final Color? glowColor;
  final double glowRadius;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const NeonCard({
    super.key,
    required this.child,
    this.gradient,
    this.glowColor,
    this.glowRadius = 20,
    this.onTap,
    this.padding,
    this.margin,
  });

  @override
  State<NeonCard> createState() => _NeonCardState();
}

class _NeonCardState extends State<NeonCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glowColor = widget.glowColor ?? AppColors.neonPink;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: widget.margin ?? const EdgeInsets.all(8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: widget.gradient ?? AppColors.sunsetGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: glowColor.withOpacity(_isHovered ? 0.6 : 0.3),
                  blurRadius: _isHovered ? widget.glowRadius * 1.5 : widget.glowRadius,
                  spreadRadius: _isHovered ? 3 : 1,
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: widget.padding ?? const EdgeInsets.all(16),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class NeonStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const NeonStatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NeonCard(
      glowColor: color,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
              shadows: [
                Shadow(color: color, blurRadius: 10),
              ],
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0);
  }
}
