// lib/features/dashboard/widgets/sales_line_chart.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesLineChart extends StatelessWidget {
  const SalesLineChart({super.key});

  final Color line1Color = const Color(0xFF4CAF50); // Green - e.g., Revenue
  final Color line2Color = const Color(0xFFF44336); // Red - e.g., Expenses
  // final Color betweenColor = const Color(0xFFF44336);

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    if (value.toInt() < months.length) {
      return SideTitleWidget(axisSide: meta.axisSide, child: Text(months[value.toInt()], style: style));
    }
    return const SizedBox();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    return SideTitleWidget(axisSide: meta.axisSide, child: Text('\$${value.toInt()}k', style: style));
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 20, top: 20, bottom: 12),
        child: LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: true), // Enable touch for tooltips
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 2,
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, interval: 1, getTitlesWidget: bottomTitleWidgets),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40, getTitlesWidget: leftTitleWidgets),
              ),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            minY: 0,
            maxY: 10,
            lineBarsData: [
              // Revenue Line (Green)
              LineChartBarData(
                spots: const [
                  FlSpot(0, 4), FlSpot(1, 3.5), FlSpot(2, 4.5), FlSpot(3, 1),
                  FlSpot(4, 4), FlSpot(5, 6), FlSpot(6, 6.5), FlSpot(7, 6),
                  FlSpot(8, 4), FlSpot(9, 6), FlSpot(10, 6), FlSpot(11, 7),
                ],
                isCurved: true,
                color: line1Color,
                barWidth: 3,
                dotData: const FlDotData(show: false),
              ),
              // Expenses Line (Red)
              LineChartBarData(
                spots: const [
                  FlSpot(0, 7), FlSpot(1, 3), FlSpot(2, 4), FlSpot(3, 2),
                  FlSpot(4, 3), FlSpot(5, 4), FlSpot(6, 5), FlSpot(7, 3),
                  FlSpot(8, 1), FlSpot(9, 8), FlSpot(10, 1), FlSpot(11, 3),
                ],
                isCurved: false,
                color: line2Color,
                barWidth: 3,
                dotData: const FlDotData(show: false),
              ),
            ],
            betweenBarsData: [
              BetweenBarsData(
                fromIndex: 0,
                toIndex: 1,
                // color: betweenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}