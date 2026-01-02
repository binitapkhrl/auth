import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auth/core/widgets/app_primary_button.dart';
import 'package:auth/core/widgets/navigation_bar.dart';
import 'package:auth/features/dashboard/widgets/revenue_chart.dart';
import 'package:auth/features/dashboard/widgets/dashboard_appbar.dart';
import 'package:auth/features/dashboard/widgets/promo_card.dart';
import 'package:auth/features/dashboard/widgets/share_link_card.dart';
import 'package:auth/features/dashboard/widgets/performance_summary.dart';
import 'package:auth/features/dashboard/widgets/chart_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: const DashboardAppBar(),
 
      body: SafeArea(
  child: SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              width: 150,
              height: 36,
              child: AppPrimaryButton(
                text: "Visit Store",
                icon: Icons.open_in_new,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                onPressed: () async {
                  final theme = Theme.of(context);
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text('Leaving App'),
                      content: const Text('You are leaving our app. Are you sure?'),
                      actions: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context, false),
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
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true) {
  final url = Uri.parse(
    "https://youtu.be/Txn5-dKLFHg?si=n945OH4FgALdz-Uq",
  );

  final success = await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  );

  if (!success) {
    debugPrint('Failed to launch $url');
  }
}

                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        /// Promo card
        const PromoCard(),
        const SizedBox(height: 32),

        /// Share link card
        const ShareLinkCard(
          storeLink: "https://youtu.be/Txn5-dKLFHg?si=n945OH4FgALdz-Uq",
        ),
        const SizedBox(height: 32),
        /// Performance summary
        const PerformanceSummary(),
        const SizedBox(height: 40),
        /// Weekly order count chart
        const ChartCard(),
        const SizedBox(height: 32),
        /// Weekly revenue chart
        const WeeklyRevenueChart(),
        const SizedBox(height: 50),
         // bottom scroll spacing
      ],
    ),
  ),
),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 10,
        ),
        child: const CustomBottomNavBar(),
      ),
    );
  }
}
