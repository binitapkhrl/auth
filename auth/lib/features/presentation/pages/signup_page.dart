import 'package:flutter/material.dart';
import 'package:auth/core/widgets/app_textfield.dart';
import 'package:auth/core/widgets/custom_submit_button.dart';
import 'package:auth/core/widgets/custom_google_button.dart';
import 'package:auth/core/widgets/auth_container.dart';
import 'package:beamer/beamer.dart';
import 'package:auth/core/utils/login_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:auth/features/auth/providers/signup_provider.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});
@override
Widget build(BuildContext context, WidgetRef ref) {
  final formKey = useMemoized(() => GlobalKey<FormState>());
  final emailController = useTextEditingController();
  final passwordController = useTextEditingController();
  final signupState = ref.watch(signupProvider);

  final theme = Theme.of(context);
  final primaryGold = theme.colorScheme.primary;
  final screenHeight = MediaQuery.of(context).size.height;

  return Scaffold(
    backgroundColor: primaryGold,
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: [
        /// Header
        SizedBox(height: screenHeight * 0.4),
        SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create your account',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Sign up to start managing your store',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.15),

        /// Scrollable Card
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.28),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: AuthContainer(
                    child: Form(
                      key: formKey, // ← Using hook
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppTextField(
                            label: 'Email',
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController, // ← Using hook
                            validator: LoginUtils.validateEmail,
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            label: 'Password',
                            hintText: 'Enter your password',
                            isPassword: true,
                            controller: passwordController, // ← Using hook
                            validator: LoginUtils.validatePassword,
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'By signing up you agree to our ',
                                ),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(
                                    color: primaryGold,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: primaryGold,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          AppPrimaryButton(
                            text: signupState.isLoading ? 'Signing up...' : 'Sign Up',
                            onPressed: signupState.isLoading
                                ? null
                                : () {
                                    if (!(formKey.currentState?.validate() ?? false)) {
                                      return;
                                    }

                                    ref.read(signupProvider.notifier).signUp(
                                          email: emailController.text.trim(),
                                          password: passwordController.text.trim(),
                                          onSuccess: () {
                                            Beamer.of(context).beamToNamed('/otp');
                                          },
                                          onError: (error) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(error),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          },
                                        );
                                  },
                          ),
                          const SizedBox(height: 16),
                          AppGoogleButton(
                            onPressed: signupState.isLoading ? null : () {},
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Beamer.of(context).beamBack(),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: primaryGold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Back button overlay
        Positioned(
          top: 0,
          left: 0,
          child: SafeArea(
            child: GestureDetector(
              onTap: () => Beamer.of(context).beamBack(),
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.arrow_back, size: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}