import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/student_provider.dart';

class YearBarChart extends StatelessWidget {
  const YearBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    int yearCount(int year) =>
        provider.students.where((s) => s.yearLevel == year).length;

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Students per Year Level",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text("${value.toInt() + 1}");
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    for (int i = 0; i < 4; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: yearCount(i + 1).toDouble(),
                            width: 35,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
