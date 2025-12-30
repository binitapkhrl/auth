import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (onBack != null)
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: onBack,
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
