import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auth/core/widgets/app_primary_button.dart';
import 'package:auth/core/widgets/navigation_bar.dart';
import 'package:auth/core/widgets/revenue_chart.dart';
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
              width: 120,
              height: 36,
              child: AppPrimaryButton(
                text: "Visit Store",
                fontSize: 12,
                onPressed: () {},
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
          storeLink: "https://saauzi.com/your-store-link",
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
