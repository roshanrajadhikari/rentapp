import 'package:test_app/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Color> gradientColors = [primary];

LineChartData mainData() {
  return LineChartData(
    gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.1,
          );
        }),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        getTextStyles: (value) =>
            const TextStyle(color: Color(0xff68737d), fontSize: 12),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '1';
            case 3:
              return '7';
            case 6:
              return '14';
            case 8:
              return '31';
          }
          return '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xff67727d),
          fontSize: 12,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '\$500';
            case 2:
              return '\$1k';
            case 3:
              return '\$1.5k';
            case 4:
              return '\$2k';
            case 5:
              return '\$2.5k';
            case 6:
              return '\$3k';
          }
          return '';
        },
        reservedSize: 28,
        margin: 12,
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, 2),
          FlSpot(7, 2),
          FlSpot(8, 6),
        ],
        isCurved: true,
        colors: gradientColors,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
    ],
  );
}
