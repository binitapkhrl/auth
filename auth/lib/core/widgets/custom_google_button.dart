import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class AppGoogleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const AppGoogleButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryGold = theme.colorScheme.primary;

    // Loading state
    if (isLoading) {
      return OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          side: BorderSide(color: Colors.grey.shade300, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(primaryGold),
          ),
        ),
      );
    }

    // Normal state - using the official pre-built Google button
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SignInButton(
          Buttons.google,           // Uses the official Google logo and styling
          text: 'Sign in with Google',
          onPressed: onPressed ?? () {},
          // Optional: slightly adjust text style if needed
          // textStyle: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}