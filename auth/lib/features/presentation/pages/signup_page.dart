import 'package:flutter/material.dart';
import 'package:auth/core/widgets/app_textfield.dart';
import 'package:auth/core/widgets/custom_submit_button.dart';
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

    final theme = Theme.of(context);
    final primaryGold = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: primaryGold,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            AuthHeader(
              title: 'Create your account',
              subtitle: 'Sign up to start managing your store',
              onBack: () => Beamer.of(context).beamBack(),
            ),

            const SizedBox(height: 24),

            // ================= WHITE CARD =================
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                    final needsScroll = keyboardHeight > 0;

                    final content = Padding(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 32,
                        bottom: keyboardHeight > 0 ? keyboardHeight + 24 : 24,
                      ),
                      child: AuthContainer(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppTextField(
                                label: 'Email',
                                hintText: 'Enter your email',
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                validator: LoginUtils.validateEmail,
                              ),
                          const SizedBox(height: 20),
                          AppTextField(
                            label: 'Password',
                            hintText: 'Enter your password',
                            isPassword: true,
                            controller: passwordController,
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
                            text: signupState.isLoading
                                ? 'Signing up...'
                                : 'Sign Up',
                            onPressed: signupState.isLoading
                                ? null
                                : () {
                                    if (!(formKey.currentState?.validate() ??
                                        false)) return;

                                    ref
                                        .read(signupProvider.notifier)
                                        .signUp(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          onSuccess: () {
                                            Beamer.of(context)
                                                .beamToNamed('/otp');
                                          },
                                          onError: (error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
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
                            onPressed:
                                signupState.isLoading ? null : () {},
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
                                onTap: () =>
                                    Beamer.of(context).beamBack(),
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

                          const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    );

                    return SingleChildScrollView(child: content);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
