import 'package:flutter/material.dart';
import 'package:auth/core/widgets/app_textfield.dart';
import 'package:auth/core/widgets/custom_submit_button.dart';
import 'package:auth/core/widgets/custom_google_button.dart';
import 'package:auth/core/widgets/auth_container.dart';
import 'package:auth/core/widgets/auth_header.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:auth/core/utils/login_utils.dart';
import 'package:auth/features/auth/providers/login_provider.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryGold = theme.colorScheme.primary;
    final loginState = ref.watch(loginProvider);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final rememberMe = useState(false);
    final errorMessage = useState<String?>(null);

    void handleLogin() {
      final isValid = formKey.currentState?.validate() ?? false;
      if (!isValid) return;

      errorMessage.value = null;
      ref.read(loginProvider.notifier).login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        onSuccess: () {
          Beamer.of(context).beamToReplacementNamed('/home');
        },
        onError: (error) {
          errorMessage.value = error;
        },
      );
    }

    return Scaffold(
      backgroundColor: primaryGold,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            AuthHeader(
              title: 'Login Saauzi',
              subtitle: 'Please sign in to continue to your account',
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
                    // final needsScroll = keyboardHeight > 0;

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
                              // Error message display
                              if (errorMessage.value != null)
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
                                          style: TextStyle(
                                            color: Colors.red.shade700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (errorMessage.value != null) const SizedBox(height: 16),
                              
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
                                onFieldSubmitted: handleLogin,
                              ),
                          const SizedBox(height: 12),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberMe.value,
                                    onChanged: (value) {
                                      rememberMe.value = value ?? false;
                                    },
                                  ),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Beamer.of(context).beamToNamed('/otp');
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: primaryGold,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // ================= LOGIN BUTTON =================
                          AppPrimaryButton(
                            text: loginState.isLoading
                                ? 'Logging in...'
                                : 'Log In',
                            onPressed: loginState.isLoading ? null : handleLogin,
                          ),

                          const SizedBox(height: 16),

                          // ================= GOOGLE BUTTON =================
                          AppGoogleButton(
                            onPressed:
                                loginState.isLoading ? null : () {},
                          ),

                          const SizedBox(height: 40),

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
                                onTap: () => Beamer.of(context)
                                    .beamToNamed('/signup'),
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
