import 'package:beamer/beamer.dart';
import 'package:auth/features/presentation/pages/login_page.dart';
import 'package:auth/features/presentation/pages/signup_page.dart';
import 'package:auth/features/presentation/pages/otp_page.dart';
import 'package:auth/features/presentation/pages/dashboard.dart'; 
import 'package:auth/features/presentation/pages/menu_page.dart';
import 'routes.dart';

class AppRouter {
  static final BeamerDelegate routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        AppRoutes.login: (context, state, data) => const LoginPage(),
        AppRoutes.signup: (context, state, data) => const SignUpPage(),
        AppRoutes.otp: (context, state, data) => const OtpVerificationPage(),
        AppRoutes.home: (context, state, data) => const DashboardScreen(),
        AppRoutes.menu : (context, state, data) => const MenuPage(),
      },
    ).call,
  );
}


