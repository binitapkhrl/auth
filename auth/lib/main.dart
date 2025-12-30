import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Saauzi Auth',

      /// Beamer Setup
      routeInformationParser: BeamerParser(),
      routerDelegate: AppRouter.routerDelegate,

      /// Theme Setup
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF7518),
          primary: const Color(0xFFFF7518),
        ),
      ),
    );
  }
}
