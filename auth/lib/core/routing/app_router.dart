import 'package:beamer/beamer.dart';
import 'package:auth/features/presentation/pages/login_page.dart';
import 'routes.dart';

class AppRouter {
  static final BeamerDelegate routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        AppRoutes.login: (context, state, data) => const LoginPage(),
        // AppRoutes.signup: (context, state, data) => const SignUpPage(),
        // AppRoutes.home: (context, state, data) => const HomePage(),
      },
    ).call,
  );
}
