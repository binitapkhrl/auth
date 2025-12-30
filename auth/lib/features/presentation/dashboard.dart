import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auth/core/widgets/app_primary_button.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      final theme = Theme.of(context);
  
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
                  'assets/logo/saauzi_logo.png',
                  height: 40, 
                 fit: BoxFit.contain, 
                  errorBuilder: (context, error, stackTrace) => 
                      const Text("LOGO", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_none_outlined, color: theme.colorScheme.primary),
                onPressed: () {
                  // Handle notification tap
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
  child: Column( // Added a Column so you can add more dashboard content below
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pushes items to extremes
        children: [
          const Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          SizedBox(
            width: 140, 
            height: 48, // Slightly shorter than the 56 default for a top-bar look
            child: AppPrimaryButton(
              text: "Visit Store 🏪",
              onPressed: () {
                // Handle navigation
              },
            ),
          ),
        ],
      ),
      // Future dashboard widgets go here...
    ],
  ),
),
    );
  }
}