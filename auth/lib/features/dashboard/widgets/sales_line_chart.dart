
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math'; // Required for the max() function

class SalesLineChart extends HookConsumerWidget {
  const SalesLineChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Define the Data Map
    final salesDataMap = useMemoized(() => {
          "2024": {
            "revenue": const [
              FlSpot(0, 4), FlSpot(1, 3.5), FlSpot(2, 4.5), FlSpot(3, 1),
              FlSpot(4, 4), FlSpot(5, 6), FlSpot(6, 6.5),
            ],
            "expenses": const [
              FlSpot(0, 7), FlSpot(1, 3), FlSpot(2, 4), FlSpot(3, 2),
              FlSpot(4, 3), FlSpot(5, 4), FlSpot(6, 5),
            ]
          },
          "2023": {
            "revenue": const [
              FlSpot(0, 3), FlSpot(1, 4), FlSpot(2, 3), FlSpot(3, 5),
              FlSpot(4, 5), FlSpot(5, 4), FlSpot(6, 4),
            ],
            "expenses": const [
              FlSpot(0, 2), FlSpot(1, 2), FlSpot(2, 3), FlSpot(3, 3),
              FlSpot(4, 4), FlSpot(5, 3), FlSpot(6, 2),
            ]
          }
        });

    final selectedYear = useState("2024");

    final currentRevenue = salesDataMap[selectedYear.value]!["revenue"]!;
    final currentExpenses = salesDataMap[selectedYear.value]!["expenses"]!;

    // 2. CALCULATE DYNAMIC MAX Y
    // Find the highest point across BOTH lists
    final double maxRev = currentRevenue.map((e) => e.y).reduce(max);
    final double maxExp = currentExpenses.map((e) => e.y).reduce(max);
    
    // Determine the ceiling: use the larger of the two and add  buffer
    final double dynamicMaxY = (max(maxRev, maxExp) * 1.5);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Sales Overview", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              DropdownButton<String>(
                value: selectedYear.value,
                items: salesDataMap.keys
                    .map((year) => DropdownMenuItem(value: year, child: Text(year)))
                    .toList(),
                onChanged: (val) => selectedYear.value = val!,
                underline: const SizedBox(),
                style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1.8,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 20, top: 20, bottom: 12),
            child: LineChart(
              LineChartData(
                lineTouchData: const LineTouchData(enabled: true),
                // Horizontal grid lines scale with the dynamic max
                gridData: FlGridData(
                  show: true, 
                  drawVerticalLine: false, 
                  horizontalInterval: (dynamicMaxY / 4).clamp(0.1, double.infinity),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: _bottomTitleWidgets),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        // Interval ensures 4-5 labels regardless of data scale
                        interval: (dynamicMaxY / 4).clamp(0.1, double.infinity),
                        getTitlesWidget: _leftTitleWidgets),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minY: 0,
                maxY: dynamicMaxY, // Applied the calculated dynamic max
                lineBarsData: [
                  _buildBarData(currentRevenue, const Color(0xFF4CAF50)),
                  _buildBarData(currentExpenses, const Color(0xFFF44336), isCurved: false),
                ],
              ),
              duration: const Duration(milliseconds: 400),
            ),
          ),
        ),
      ],
    );
  }

  LineChartBarData _buildBarData(List<FlSpot> spots, Color color, {bool isCurved = true}) {
    return LineChartBarData(
      spots: spots,
      isCurved: isCurved,
      color: color,
      barWidth: 3,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: true, color: color.withAlpha(25)),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey);
    const months = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    if (value.toInt() >= 0 && value.toInt() < months.length) {
      return SideTitleWidget(
          axisSide: meta.axisSide, 
          child: Text(months[value.toInt()], style: style));
    }
    return const SizedBox();
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    if (value == meta.max) return const SizedBox(); // Hide top-most label to prevent clipping
    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text('\$${value.toStringAsFixed(1)}k', 
            style: const TextStyle(fontSize: 10, color: Colors.grey)));
  }
}