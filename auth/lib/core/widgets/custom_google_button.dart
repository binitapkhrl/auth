import 'package:flutter/material.dart';
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

    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(primaryGold),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google Icon (you can use SVG or PNG asset)
                Image.asset(
                  'assets/images/google_logo.png', // Add this asset to your pubspec.yaml
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Libadora',
                  ),
                ),
              ],
            ),
    );
  }
}