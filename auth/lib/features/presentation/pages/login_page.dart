import 'package:flutter/material.dart';
import 'package:auth/core/widgets/app_textfield.dart';
import 'package:auth/core/widgets/custom_submit_button.dart';
import 'package:auth/core/widgets/custom_google_button.dart';
import 'package:auth/core/widgets/auth_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryGold = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: primaryGold,
      resizeToAvoidBottomInset: true, // Allows layout to resize when keyboard opens
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Gold Section: Title + Subtitle
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
                child: Column(
                  children: [
                    Text(
                      'Login Saauzi',
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Please sign in to continue to your account',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Reusable AuthCard containing the entire form
              AuthCard(
                // No title/subtitle here — we keep the main title in the gold section
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppTextField(
                      label: 'Email',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    const AppTextField(
                      label: 'Password',
                      hintText: 'Enter your password',
                      isPassword: true,
                    ),
                    const SizedBox(height: 32),
                    AppPrimaryButton(
                      text: 'Log In',
                      onPressed: () {
                        // Handle login logic
                      },
                    ),
                    const SizedBox(height: 16),
                    AppGoogleButton(
                      onPressed: () {
                        // Handle Google sign-in
                      },
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: primaryGold,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40), // Safe bottom padding when keyboard is open
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}