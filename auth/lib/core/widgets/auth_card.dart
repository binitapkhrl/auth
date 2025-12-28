import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  /// The main content inside the card (fields, buttons, etc.)
  final Widget child;

  /// Optional title shown at the top of the card
  final String? title;

  /// Optional subtitle below the title
  final String? subtitle;

  /// Horizontal padding inside the card (default matches your design)
  final double horizontalPadding;

  const AuthCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.horizontalPadding = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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

          // Add spacing if title/subtitle exists
          if (title != null || subtitle != null) const SizedBox(height: 32),

          // Main form content (fields, buttons, etc.)
          child,
        ],
      ),
    );
  }
}