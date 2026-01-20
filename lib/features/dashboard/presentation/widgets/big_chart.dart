import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/models/hg_history_point.dart';

class BigChart extends StatelessWidget {
  const BigChart({super.key, required this.points});

  final List<HgHistoryPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.length < 2) {
      return Container(
        height: 220,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.10)),
          color: Colors.white.withOpacity(0.06),
        ),
        child: Text(
          'Waiting for data…',
          style: TextStyle(color: Colors.white.withOpacity(0.65)),
        ),
      );
    }

    final cliSpots = <FlSpot>[];
    final noiseSpots = <FlSpot>[];

    // Map x = index, y = value
    for (int i = 0; i < points.length; i++) {
      cliSpots.add(FlSpot(i.toDouble(), points[i].cli.toDouble()));
      noiseSpots.add(FlSpot(i.toDouble(), points[i].noise.toDouble()));
    }

    return Container(
      height: 220,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
        color: Colors.white.withOpacity(0.06),
      ),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 25,
            getDrawingHorizontalLine: (v) => FlLine(
              color: Colors.white.withOpacity(0.10),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 25,
                reservedSize: 28,
                getTitlesWidget: (v, meta) => Text(
                  v.toInt().toString(),
                  style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 11),
                ),
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.white.withOpacity(0.10)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: cliSpots,
              isCurved: true,
              barWidth: 2.5,
              color: Theme.of(context).colorScheme.primary,
              dotData: const FlDotData(show: false),
            ),
            LineChartBarData(
              spots: noiseSpots,
              isCurved: true,
              barWidth: 2,
              color: const Color(0xFFFF4D6D),
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
