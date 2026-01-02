import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

class WeeklyRevenueChart extends HookConsumerWidget {
  const WeeklyRevenueChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    // 1. Define your dynamic data
    final weeklyRevenueData = useMemoized(() => {
          "This Week": {
            "spots": const [
              FlSpot(0, 12000), FlSpot(1, 15000), FlSpot(2, 11000),
              FlSpot(3, 18000), FlSpot(4, 22000), FlSpot(5, 25000),
              FlSpot(6, 100000),
            ],
            "avg": "1,25,467",
          },
          "Last Week": {
            "spots": const [
              FlSpot(0, 10000), FlSpot(1, 12000), FlSpot(2, 9000),
              FlSpot(3, 14000), FlSpot(4, 18000), FlSpot(5, 20000),
              FlSpot(6, 17000),
            ],
            "avg": "98,320",
          },
          "2 Weeks Ago": {
            "spots": const [
              FlSpot(0, 8000), FlSpot(1, 7000), FlSpot(2, 12000),
              FlSpot(3, 10000), FlSpot(4, 13000), FlSpot(5, 15000),
              FlSpot(6, 14000),
            ],
            "avg": "85,150",
          },
        });

    final selectedWeek = useState("This Week");

    // Extract current data
    final currentData = weeklyRevenueData[selectedWeek.value]!["spots"] as List<FlSpot>;
    final currentAvg = weeklyRevenueData[selectedWeek.value]!["avg"] as String;

    // 2. CALCULATE DYNAMIC MAX Y
    // We find the highest value and add a 20% buffer so the line doesn't hit the ceiling
    final double highestY = currentData.isEmpty 
        ? 1000 
        : currentData.map((e) => e.y).reduce(max);
    final double dynamicMaxY = (highestY * 1.2).ceilToDouble();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Weekly Revenue",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedWeek.value,
                      icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      items: weeklyRevenueData.keys.map((String week) {
                        return DropdownMenuItem(value: week, child: Text(week));
                      }).toList(),
                      onChanged: (val) => selectedWeek.value = val!,
                    ),
                  ),
                ],
              ),
              _buildAvgOrderValue(primaryColor, currentAvg),
            ],
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.8,
            child: LineChart(
              _buildChartData(primaryColor, currentData, dynamicMaxY),
              duration: const Duration(milliseconds: 400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvgOrderValue(Color color, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Avg Order Value", style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
        Text(
          "₹$value",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  LineChartData _buildChartData(Color color, List<FlSpot> spots, double maxY) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        // Draw 5 horizontal lines regardless of the scale
        horizontalInterval: maxY / 5,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withAlpha(25),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
              if (value >= 0 && value < days.length) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 8,
                  child: Text(days[value.toInt()], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                );
              }
              return const SizedBox();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            // Show labels at every 20% of the max value
            interval: maxY / 5,
            getTitlesWidget: (value, meta) {
              if (value == 0) return const SizedBox();
              return Text(
                '₹${(value / 1000).toStringAsFixed(0)}k', 
                style: const TextStyle(fontSize: 9, color: Colors.grey)
              );
            },
            reservedSize: 40,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: maxY, // Applied dynamic max
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          curveSmoothness: 0.35,
          color: color,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true, 
            color: color.withAlpha(38)
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => Colors.black.withAlpha(204),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) => LineTooltipItem(
              '₹${spot.y.toInt()}',
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )).toList();
          },
        ),
      ),
    );
  }
}