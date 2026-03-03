import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/dashboard_page.dart';
import '../../features/fitness/presentation/fitness_page.dart';
import '../../features/finance/presentation/finance_page.dart';
import '../../features/assurance/presentation/assurance_page.dart';
import '../../features/ai_assistant/presentation/ai_chat_page.dart';
import '../../shared/widgets/synthwave_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/dashboard',
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) => SynthwaveShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardPage(),
            ),
          ),
          GoRoute(
            path: '/fitness',
            name: 'fitness',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FitnessPage(),
            ),
          ),
          GoRoute(
            path: '/finance',
            name: 'finance',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FinancePage(),
            ),
          ),
          GoRoute(
            path: '/assurance',
            name: 'assurance',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AssurancePage(),
            ),
          ),
          GoRoute(
            path: '/ai',
            name: 'ai_assistant',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AIChatPage(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
});
