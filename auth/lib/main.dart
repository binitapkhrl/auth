import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
 const MyApp({super.key});
  @override
 Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Saauzi Auth',

      /// Beamer Setup
      routeInformationParser: BeamerParser(),
      routerDelegate: AppRouter.routerDelegate,

      /// Theme Setup
      theme: AppTheme.lightTheme,
    );
  }
}
