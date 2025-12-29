import 'package:flutter/material.dart';
import 'package:auth/core/widgets/app_textfield.dart';
import 'package:auth/core/widgets/custom_submit_button.dart'; // AppPrimaryButton
import 'package:auth/core/widgets/custom_google_button.dart'; // AppGoogleButton
import 'package:auth/core/widgets/auth_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:auth/core/utils/login_utils.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryGold = theme.colorScheme.primary;
    // final screenHeight = MediaQuery.of(context).size.height;

   return Scaffold(
  backgroundColor: primaryGold,
  resizeToAvoidBottomInset: true,
  body: SafeArea(
    child: Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Beamer.of(context).beamBack(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.arrow_back, size: 24, color: Colors.black),
                    SizedBox(width: 4),
                    Text(
                      'Back',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Create your account',
                style: theme.textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Sign up to start managing your store',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // White form container
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                child: AuthContainer(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTextField(
                          label: 'Email',
                          hintText: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: LoginUtils.validateEmail,
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          isPassword: true,
                          controller: _passwordController,
                          validator: LoginUtils.validatePassword,
                        ),
                        const SizedBox(height: 16),
                        // Terms & Privacy Policy
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                            children: [
                              const TextSpan(
                                  text: 'By signing up you agree to our '),
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
                          text: 'Sign Up',
                          onPressed: () {
                            if (!(_formKey.currentState?.validate() ?? false)) {
                              return;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        AppGoogleButton(
                          onPressed: () {},
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
                                  Beamer.of(context).beamToNamed('/login'),
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