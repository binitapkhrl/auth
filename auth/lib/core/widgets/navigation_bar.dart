import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auth/features/auth/providers/navigation_provider.dart';
import 'package:beamer/beamer.dart';

class CustomBottomNavBar extends HookConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navIndexProvider);
    final primary = Theme.of(context).colorScheme.primary;

    void _onTap(int index) {
      ref.read(navIndexProvider.notifier).state = index;

      switch (index) {
        case 0:
          Beamer.of(context).beamToNamed('/home');
          break;
        case 1:
          Beamer.of(context).beamToNamed('/orders');
          break;
        case 2:
          Beamer.of(context).beamToNamed('/account'); // change to your route
          break;
        case 3:
          Beamer.of(context).beamToNamed('/menu');
          break;
      }
    }

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavBarItem(
            icon: Icons.home_outlined,
            label: "Home",
            isActive: selectedIndex == 0,
            onTap: () => _onTap(0),
          ),
          _NavBarItem(
            icon: Icons.storefront_outlined,
            label: "Products",
            isActive: selectedIndex == 1,
            onTap: () => _onTap(1),
          ),
          _NavBarItem(
            icon: Icons.person_outline,
            label: "Account",
            isActive: selectedIndex == 2,
            onTap: () => _onTap(2),
          ),
          _NavBarItem(
            icon: Icons.menu,
            label: "Menu",
            isActive: selectedIndex == 3,
            onTap: () => _onTap(3),
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

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
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
