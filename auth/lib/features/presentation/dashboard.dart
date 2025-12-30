import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:beamer/beamer.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // Ensures status bar icons are visible (dark icons for light bg)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2), // Positioned to look like a line
                blurRadius: 1,
              ),
            ],
          ),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark, // Status bar visibility
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 100,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Center(
                child: Image.asset(
                  'assets/logo/saauzi_logo.png', // PLACEHOLDER FOR YOUR PNG
                  errorBuilder: (context, error, stackTrace) => 
                      const Text("LOGO", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined, color: Colors.black87),
                onPressed: () {
                  // Handle notification tap
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text("Dashboard Content Goes Here"),
      ),
    );
  }
}