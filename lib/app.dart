import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/synthwave_theme.dart';
import 'core/router/app_router.dart';

class OpenLifeApp extends ConsumerWidget {
  const OpenLifeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'Open Life',
      debugShowCheckedModeBanner: false,
      theme: SynthwaveTheme.light,
      darkTheme: SynthwaveTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
