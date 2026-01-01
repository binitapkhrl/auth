import 'package:flutter/material.dart';
import 'package:auth/core/widgets/stat_box.dart';

class PerformanceSummary extends StatelessWidget {
  const PerformanceSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      child: Text(
        "Performance Summary",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    ),
    TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.tune, size: 18),
      label: const Text("Apply Filter"),
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.primary,
      ),
    ),
  ],
),

    const SizedBox(height: 16),

    // First Row: Larger, prominent stats
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Expanded(
          child: StatBox(
            icon: Icons.shopping_bag_outlined,
            value: "1.3k",
            label: "Total Orders",
            height: 170,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatBox(
            icon: Icons.inventory_2_outlined,
            value: "248",
            label: "Total Products",
            height: 170,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatBox(
            icon: Icons.star_outline,
            value: "56",
            label: "Featured Products",
            height: 170,
          ),
        ),
      ],
    ),

    const SizedBox(height: 24),
 const Text(
          "Order Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 24),
    // Second Row: Smaller secondary stats
    Row(
      children: const [
        Expanded(
          child: StatBox(
            icon: Icons.check_circle_outline,
            value: "1.1k",
            label: "Total Orders",
            height: 150,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatBox(
            icon: Icons.local_shipping_outlined,
            value: "892",
            label: "Shipped Orders",
            height: 150,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatBox(
            icon: Icons.pending_outlined,
            value: "408",
            label: "Pending Orders",
            height: 150,
          ),
        ),
      ],
    ),
],
);
  }
}
  