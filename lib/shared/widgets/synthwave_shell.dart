import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../core/theme/app_colors.dart';


class SynthwaveShell extends ConsumerStatefulWidget {
  final Widget child;

  const SynthwaveShell({super.key, required this.child});

  @override
  ConsumerState<SynthwaveShell> createState() => _SynthwaveShellState();
}

class _SynthwaveShellState extends ConsumerState<SynthwaveShell> {
  int _selectedIndex = 0;

  final List<_NavItem> _navItems = [
    _NavItem(
      icon: PhosphorIcons.house(),
      activeIcon: PhosphorIconsFill.house,
      label: 'Home',
      path: '/dashboard',
    ),
    _NavItem(
      icon: PhosphorIcons.barbell(),
      activeIcon: PhosphorIconsFill.barbell,
      label: 'Fitness',
      path: '/fitness',
    ),
    _NavItem(
      icon: PhosphorIcons.wallet(),
      activeIcon: PhosphorIconsFill.wallet,
      label: 'Finance',
      path: '/finance',
    ),
    _NavItem(
      icon: PhosphorIcons.heart(),
      activeIcon: PhosphorIconsFill.heart,
      label: 'Health',
      path: '/assurance',
    ),
    _NavItem(
      icon: PhosphorIcons.sparkle(),
      activeIcon: PhosphorIconsFill.sparkle,
      label: 'AI',
      path: '/ai',
    ),
    _NavItem(
      icon: PhosphorIcons.gearSix(),
      activeIcon: PhosphorIconsFill.gearSix,
      label: 'Settings',
      path: '/settings',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    context.go(_navItems[index].path);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).matchedLocation;
    final index = _navItems.indexWhere((item) => location.startsWith(item.path));
    if (index != -1 && index != _selectedIndex) {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundDarker,
              AppColors.backgroundDark,
              Color(0xFF0D0D20),
            ],
          ),
        ),
        child: widget.child,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundDarker,
              Color(0xFF080815),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.electricPurple,
              blurRadius: 20,
              spreadRadius: -5,
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          height: 70,
          destinations: _navItems.map((item) {
            final isSelected = _navItems.indexOf(item) == _selectedIndex;
            return NavigationDestination(
              icon: Icon(
                item.icon,
                size: 26,
                color: AppColors.textMuted,
              ),
              selectedIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppColors.sunsetGradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.neonPink.withOpacity(0.5),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  item.activeIcon,
                  size: 26,
                  color: AppColors.textPrimary,
                ),
              ),
              label: item.label,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String path;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.path,
  });
}
