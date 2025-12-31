import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyRevenueChart extends StatelessWidget {
  const WeeklyRevenueChart({super.key});

  // Mock daily revenue data for this week (replace with real data later)
  final List<FlSpot> weeklyData = const [
    FlSpot(0, 12000),  // Mon
    FlSpot(1, 15000),  // Tue
    FlSpot(2, 11000),  // Wed
    FlSpot(3, 18000),  // Thu
    FlSpot(4, 22000),  // Fri
    FlSpot(5, 25000),  // Sat
    FlSpot(6, 20000),  // Sun
  ];

  // Average Order Value (mock - format with Indian commas)
  final String avgOrderValue = "1,25,467";

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
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
          // Title and Avg Order Value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "This Week's Revenue",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Avg Order Value",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    "₹$avgOrderValue",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // The Line Chart
          AspectRatio(
            aspectRatio: 1.8,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 5000,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.shade200,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        if (value.toInt() < days.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              days[value.toInt()],
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 5000,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '₹${(value / 1000).toInt()}k',
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 30000,
                lineBarsData: [
                  LineChartBarData(
                    spots: weeklyData,
                    isCurved: true,
                    color: primaryColor,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: primaryColor.withAlpha(38),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
  enabled: true,

  handleBuiltInTouches: true,
  touchTooltipData: LineTouchTooltipData(
    getTooltipColor: (_) => Colors.grey.shade800.withAlpha(243),
    tooltipRoundedRadius: 12,
    tooltipPadding: const EdgeInsets.all(12),
    tooltipMargin: 8,
    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
      return touchedBarSpots.map((barSpot) {
        final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return LineTooltipItem(
          '${days[barSpot.x.toInt()]}\n₹${barSpot.y.toInt()}',
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        );
      }).toList();
    },
  ),

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}