import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:auth/core/widgets/stat_box.dart';

class PerformanceSummary extends HookWidget {
  const PerformanceSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('This Week');
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
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedFilter.value,
        items: const [
          DropdownMenuItem(value: 'Today', child: Text('Today')),
          DropdownMenuItem(value: 'This Week', child: Text('This Week')),
          DropdownMenuItem(value: 'This Month', child: Text('This Month')),
          DropdownMenuItem(value: 'This Year', child: Text('This Year')),
        ],
        onChanged: (String? newValue) {
          if (newValue != null) {
            selectedFilter.value = newValue;
          }
        },
        underline: const SizedBox(),
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
        dropdownColor: Colors.white,
      ),
    ),
  ],
),

    const SizedBox(height: 16),

    // First Row: Larger, prominent stats
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: StatBox(
            icon: Icons.shopping_bag_outlined,
            value: "1.3k",
            color: theme.colorScheme.primary,
            label: "Total Orders",
            height: 170,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatBox(
            icon: Icons.inventory_2_outlined,
            value: "248",
            label: "Total Products",
            height: 170,
          ),
        ),
        const SizedBox(width: 16),
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
