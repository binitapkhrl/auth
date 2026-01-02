import 'package:flutter/material.dart';
import 'package:auth/core/widgets/app_textfield.dart';
import 'package:auth/core/widgets/app_primary_button.dart';
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
    final scrollController = useScrollController();
    final emailFocus = useFocusNode();
    final passwordFocus = useFocusNode();

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final rememberMe = useState(false);
    final errorMessage = useState<String?>(null);

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = keyboardHeight > 0;

    // Get the total header height (AuthHeader + spacing)
    // final screenHeight = MediaQuery.of(context).size.height;
    // final safeAreaTop = MediaQuery.of(context).padding.top;
    
    // Calculate approximate header height (adjust if needed)
    final headerHeight = 180.0; // AuthHeader height + spacing

    // Scroll to hide entire header when keyboard appears
    useEffect(() {
      if (isKeyboardVisible) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              headerHeight, // Scroll exactly by header height
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            );
          }
        });
      } else {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInCubic,
          );
        }
      }
      return null;
    }, [isKeyboardVisible]);

    void handleLogin() {
      final isValid = formKey.currentState?.validate() ?? false;
      if (!isValid) return;

      errorMessage.value = null;
      ref.read(loginProvider.notifier).login(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            onSuccess: () => Beamer.of(context).beamToReplacementNamed('/home'),
            onError: (error) => errorMessage.value = error,
          );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: primaryGold,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: CustomScrollView(
            controller: scrollController,
            // Make it non-scrollable by default, only allow programmatic scrolling
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const AuthHeader(
                      title: 'Login Saauzi',
                      subtitle: 'Please sign in to continue to your account',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  padding: EdgeInsets.only(
                    bottom: isKeyboardVisible ? keyboardHeight + 16 : 32,
                  ),
                  child: AuthContainer(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (errorMessage.value != null) ...[
                            _buildErrorBox(errorMessage.value!),
                            const SizedBox(height: 16),
                          ],
                          AppTextField(
                            focusNode: emailFocus,
                            label: 'Email',
                            hintText: 'example@gmail.com',
                            controller: emailController,
                            validator: LoginUtils.validateEmail,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            focusNode: passwordFocus,
                            label: 'Password',
                            hintText: 'Enter your password',
                            isPassword: true,
                            controller: passwordController,
                            validator: LoginUtils.validatePassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: () => handleLogin(),
                          ),
                          const SizedBox(height: 12),
                          _buildOptionsRow(context, rememberMe, primaryGold),
                          const SizedBox(height: 32),
                          AppPrimaryButton(
                            text: loginState.isLoading ? 'Logging in...' : 'Log In',
                            onPressed: loginState.isLoading ? null : handleLogin,
                          ),
                          const SizedBox(height: 16),
                          AppGoogleButton(
                            onPressed: loginState.isLoading ? null : () {},
                          ),
                          const SizedBox(height: 16),
                          // TextButton(
                          //   onPressed: () => Beamer.of(context).beamToReplacementNamed('/home'),
                          //   child: Text(
                          //     'Test Login (Skip Auth)',
                          //     style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          const SizedBox(height: 24),
                          _buildFooter(context, primaryGold),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorBox(String msg) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200)),
    child: Row(children: [
      Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
      const SizedBox(width: 8),
      Expanded(child: Text(msg, style: TextStyle(color: Colors.red.shade700, fontSize: 14))),
    ]),
  );

  Widget _buildOptionsRow(BuildContext context, ValueNotifier<bool> rem, Color gold) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(children: [
        SizedBox(
          height: 24, width: 24,
          child: Checkbox(value: rem.value, onChanged: (v) => rem.value = v ?? false),
        ),
        const SizedBox(width: 8),
        Text('Remember me', style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
      ]),
      GestureDetector(
        onTap: () => Beamer.of(context).beamToNamed('/otp'),
        child: Text('Forgot Password?', style: TextStyle(color: gold, fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    ],
  );

  Widget _buildFooter(BuildContext context, Color gold) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Don't have an account? ", style: TextStyle(color: Colors.grey.shade700, fontSize: 15)),
      GestureDetector(
        onTap: () => Beamer.of(context).beamToNamed('/signup'),
        child: Text('Sign Up', style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 15)),
      ),
    ],
  );
}
