import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';

// Shimmer loading widget
class NeonShimmer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const NeonShimmer({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.backgroundCard,
      highlightColor: AppColors.backgroundCardLight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}

// Animated page transition wrapper
class AnimatedPageWrapper extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const AnimatedPageWrapper({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return child
      .animate()
      .fadeIn(duration: 400.ms, delay: delay)
      .slideY(begin: 0.05, end: 0, duration: 400.ms, delay: delay);
  }
}

// Pulse animation for important elements
class PulseGlow extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double maxGlow;

  const PulseGlow({
    super.key,
    required this.child,
    this.glowColor = AppColors.neonPink,
    this.maxGlow = 20,
  });

  @override
  State<PulseGlow> createState() => _PulseGlowState();
}

class _PulseGlowState extends State<PulseGlow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 5, end: widget.maxGlow).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.5),
                blurRadius: _animation.value,
                spreadRadius: _animation.value / 4,
              ),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}

// Slide-in animation for list items
class SlideInListItem extends StatelessWidget {
  final Widget child;
  final int index;

  const SlideInListItem({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return child
      .animate()
      .fadeIn(delay: (index * 50).ms)
      .slideX(begin: 0.1, end: 0, delay: (index * 50).ms);
  }
}

// Count up animation for numbers
class CountUpText extends StatefulWidget {
  final int target;
  final String suffix;
  final TextStyle? style;
  final Duration duration;

  const CountUpText({
    super.key,
    required this.target,
    this.suffix = '',
    this.style,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<CountUpText> createState() => _CountUpTextState();
}

class _CountUpTextState extends State<CountUpText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    
    _animation = IntTween(begin: 0, end: widget.target).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value}${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}

// Bounce animation for buttons
class BounceButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const BounceButton({super.key, required this.child, this.onTap});

  @override
  State<BounceButton> createState() => _BounceButtonState();
}

class _BounceButtonState extends State<BounceButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}

// Staggered grid animation
class StaggeredGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double spacing;

  const StaggeredGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: children.asMap().entries.map((entry) {
        return entry.value
          .animate()
          .fadeIn(delay: (entry.key * 80).ms)
          .slideY(begin: 0.1, end: 0, delay: (entry.key * 80).ms);
      }).toList(),
    );
  }
}

// Typing indicator for AI chat
class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.neonPink,
            shape: BoxShape.circle,
          ),
        ).animate(
          onPlay: (controller) => controller.repeat(),
        ).fadeIn(delay: (index * 150).ms).then().fadeOut(delay: 150.ms);
      }),
    );
  }
}
