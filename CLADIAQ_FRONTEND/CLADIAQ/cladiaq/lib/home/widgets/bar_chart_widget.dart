import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: BarChart(
        BarChartData(
          barGroups: [
            BarChartGroupData(
                x: 0, barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
            BarChartGroupData(
                x: 1, barRods: [BarChartRodData(toY: 3, color: Colors.blue)]),
            BarChartGroupData(
                x: 2, barRods: [BarChartRodData(toY: 4, color: Colors.blue)]),
          ],
          titlesData: FlTitlesData(show: true),
        ),
      ),
    );
  }
}
