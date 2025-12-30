// lib/features/auth/providers/login_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_provider.dart';

final loginControllerProvider = NotifierProvider<LoginController, void>(() {
  return LoginController();
});

class LoginController extends Notifier<void> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;

  @override
  void build() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();

    // Auto-dispose controllers
    ref.onDispose(() {
      emailController.dispose();
      passwordController.dispose();
    });
  }

  /// Validates form and triggers login
  Future<void> performLogin() async {
    if (formKey.currentState?.validate() ?? false) {
      await ref.read(loginProvider.notifier).login(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
    }
  }

  /// Optional: Clear fields after success (if needed later)
  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }
}