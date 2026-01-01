import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:auth/features/auth/providers/auth_state_provider.dart';
import 'package:auth/core/routing/routes.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
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
            color: Colors.redAccent,
            onTap: () => _confirmLogout(context, ref),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () async {
              Navigator.pop(context);

              await ref.read(authStateProvider.notifier).logout();

              Beamer.of(context).beamToReplacementNamed(AppRoutes.login);
            },
            child: const Text('Logout'),
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
