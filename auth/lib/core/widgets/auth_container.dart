import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  /// Main content inside the container (fields, buttons, OTP input, etc.)
  final Widget child;

  /// Optional title shown at the top of the container
  final String? title;

  /// Optional subtitle below the title
  final String? subtitle;

  /// Horizontal padding inside the container
  final double horizontalPadding;

  /// Vertical padding inside the container
  final double verticalPadding;

  const AuthContainer({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.horizontalPadding = 24.0,
    this.verticalPadding = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min, // lets it shrink for small content like OTP
        children: [
          // Optional Title
          if (title != null)
            Text(
              title!,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

          if (title != null && subtitle != null) const SizedBox(height: 8),

          // Optional Subtitle
          if (subtitle != null)
            Text(
              subtitle!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),

          // Spacing if title or subtitle exists
          if (title != null || subtitle != null) const SizedBox(height: 32),

          // Main form or OTP input
          child,
        ],
      ),
    );
  }
}
