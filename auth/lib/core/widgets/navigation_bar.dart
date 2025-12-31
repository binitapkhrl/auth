
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auth/features/auth/providers/navigation_provider.dart';

class CustomBottomNavBar extends HookConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navIndexProvider);
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Equal spacing
        children: [
          _NavBarItem(
            icon: Icons.home_outlined,
            label: "Home",
            isActive: selectedIndex == 0,
            onTap: () => ref.read(navIndexProvider.notifier).state = 0,
          ),
          _NavBarItem(
            icon: Icons.storefront_outlined,
            label: "Products",
            isActive: selectedIndex == 1,
            onTap: () => ref.read(navIndexProvider.notifier).state = 1,
          ),
          _NavBarItem(
            icon: Icons.person_outline,
            label: "Account",
            isActive: selectedIndex == 2,
            onTap: () => ref.read(navIndexProvider.notifier).state = 2,
          ),
          _NavBarItem(
            icon: Icons.menu,
            label: "Menu",
            isActive: selectedIndex == 3,
            onTap: () => ref.read(navIndexProvider.notifier).state = 3,
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Expanded( // Makes each item take equal width
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque, // Better tap area
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 28,
                color: isActive ? primary : Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isActive ? primary : Colors.grey,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}