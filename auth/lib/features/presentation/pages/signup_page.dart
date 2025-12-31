import 'package:flutter/material.dart';
import 'package:auth/core/widgets/app_textfield.dart';
import 'package:auth/core/widgets/app_primary_button.dart';
import 'package:auth/core/widgets/custom_google_button.dart';
import 'package:auth/core/widgets/auth_container.dart';
import 'package:auth/core/widgets/auth_header.dart';
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
    final errorMessage = useState<String?>(null);

    void handleSignup() {
      final isValid = formKey.currentState?.validate() ?? false;
      if (!isValid) return;

      errorMessage.value = null;
      ref.read(signupProvider.notifier).signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        onSuccess: () {
          Beamer.of(context).beamToNamed('/otp');
        },
        onError: (error) {
          errorMessage.value = error;
        },
      );
    }

    final theme = Theme.of(context);
    final primaryGold = theme.colorScheme.primary;

    return Scaffold(
    backgroundColor: primaryGold,
    resizeToAvoidBottomInset: true,
    body: SafeArea(
      child: Column(
        children: [
          // ================= HEADER (Fixed) =================
          AuthHeader(
            title: 'Create your account',
            subtitle: 'Sign up to start managing your store',
            onBack: () => Beamer.of(context).beamBack(),
          ),

          const SizedBox(height: 24),

          // ================= WHITE CARD (Fills remaining space) =================
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                child: SingleChildScrollView(
                  // Maintains consistent padding regardless of keyboard state
                  padding: const EdgeInsets.only(bottom: 24),
                  child: AuthContainer(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Error message display
                          if (errorMessage.value != null) ...[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      errorMessage.value!,
                                      style: TextStyle(color: Colors.red.shade700, fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          AppTextField(
                            label: 'Email',
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: LoginUtils.validateEmail,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            label: 'Password',
                            hintText: 'Enter your password',
                            isPassword: true,
                            controller: passwordController,
                            validator: LoginUtils.validatePassword,
                            textInputAction: TextInputAction.done,
                            // Fixed: Using (_) to ignore the submitted string
                            onFieldSubmitted: () => handleSignup(),
                          ),
                          const SizedBox(height: 24),

                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                              children: [
                                const TextSpan(text: 'By signing up you agree to our '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(color: primaryGold, fontWeight: FontWeight.w600),
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(color: primaryGold, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          AppPrimaryButton(
                            text: signupState.isLoading ? 'Signing up...' : 'Sign Up',
                            onPressed: signupState.isLoading ? null : handleSignup,
                          ),

                          const SizedBox(height: 16),

                          AppGoogleButton(
                            onPressed: signupState.isLoading ? null : () {},
                          ),

                          const SizedBox(height: 32),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
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
                          // Added bottom padding to ensure the last link isn't cut off
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
