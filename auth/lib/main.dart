// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:beamer/beamer.dart';
// import 'package:auth/features/presentation/pages/login_page.dart'; 

// void main() {
//   runApp(
//      ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//    MyApp({super.key});

//   // This delegate manages which page is shown based on the URL/Path
//   final routerDelegate = BeamerDelegate(
//     locationBuilder: RoutesLocationBuilder(
//       routes: {
//         // Define your routes here
//         '/': (context, state, data) => const LoginPage(),
//         // '/signup': (context, state, data) => const SignUpPage(),
//       },
//     ).call,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Saauzi Auth',
//       // Beamer Setup
//       routeInformationParser: BeamerParser(),
//       routerDelegate: routerDelegate,
//       // Theme Setup
//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFFFF7518),
//           primary: const Color(0xFFFF7518),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
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
