import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:auth/features/auth/providers/auth_state_provider.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        // automaticallyImplyLeading: false,
        leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      // Navigate back to dashboard explicitly
      Beamer.of(context).beamToReplacementNamed('/home');
    },
  ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          const SizedBox(height: 12),

          _MenuTile(
            icon: Icons.person_outline,
            title: 'Profile',
            onTap: () {},
          ),

          _MenuTile(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {},
          ),

          const Divider(height: 32),

          _MenuTile(
            icon: Icons.logout,
            title: 'Logout',
            color: theme.colorScheme.primary,
            onTap: () => _confirmLogout(context, ref),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
     final theme = Theme.of(context);
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              side: BorderSide(color: Colors.grey.shade300),
              minimumSize: const Size(0, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: theme.colorScheme.primary,
              side: BorderSide(color: theme.colorScheme.primary),
              minimumSize: const Size(0, 44),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              Navigator.pop(context);

              // Perform logout
              await ref.read(authStateProvider.notifier).logout();

              // Navigate to login and clear back stack
              Beamer.of(context).beamToReplacementNamed('/');
            },
            child: const Text('Logout'),
          ),
        ),
      ],
    ),
  );
}

}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.grey.shade700),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
