import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TemperatureChart extends StatelessWidget {
  final double upperLimit = 30; // Upper limit for poor temperature (blue line)
  final double lowerLimit = 10; // Lower limit for harsh temperature (red line)
  final double normalTemp = 20; // Normal room temperature (green line)

  final List<FlSpot> temperatureReadings = [
    FlSpot(0, 5), // Cold (Blue)
    FlSpot(1, 15), // Normal (Green)
    FlSpot(2, 25), // Normal (Green)
    FlSpot(3, 35), // Hot (Red)
    FlSpot(4, 28), // Normal (Green)
    FlSpot(5, 8), // Cold (Blue)
    FlSpot(6, 40), // Hot (Red)
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 45,
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.black, width: 1),
          ),
          lineBarsData: [
            // Main temperature line with colored dots
            LineChartBarData(
              spots: temperatureReadings,
              isCurved: true,
              color: Colors.grey,
              dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    Color dotColor;

                    if (spot.y <= lowerLimit) {
                      dotColor = Colors.blue; // Cold (below lower limit)
                    } else if (spot.y > lowerLimit && spot.y <= upperLimit) {
                      dotColor = Colors.green; // Normal temperature
                    } else {
                      dotColor = Colors.red; // Hot (above upper limit)
                    }

                    return FlDotCirclePainter(
                      radius: 4,
                      color: dotColor,
                      strokeWidth: 0,
                    );
                  }),
              belowBarData: BarAreaData(show: false),
            ),
            // Upper limit (poor temperature)
            LineChartBarData(
              spots: [
                FlSpot(0, upperLimit),
                FlSpot(6, upperLimit),
              ],
              isCurved: false,
              color: Colors.red,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
            // Normal room temperature line
            LineChartBarData(
              spots: [
                FlSpot(0, normalTemp),
                FlSpot(6, normalTemp),
              ],
              isCurved: false,
              color: Colors.green,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
            // Lower limit (harsh temperature)
            LineChartBarData(
              spots: [
                FlSpot(0, lowerLimit),
                FlSpot(6, lowerLimit),
              ],
              isCurved: false,
              color: Colors.blue,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
