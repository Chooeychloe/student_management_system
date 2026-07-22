import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/providers/student_provider.dart';

class YearBarChart extends StatelessWidget {
  const YearBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    final year1 = provider.students.where((e) => e.yearLevel == 1).length;
    final year2 = provider.students.where((e) => e.yearLevel == 2).length;
    final year3 = provider.students.where((e) => e.yearLevel == 3).length;
    final year4 = provider.students.where((e) => e.yearLevel == 4).length;

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Students by Year",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 280,
              child: BarChart(
                BarChartData(
                  maxY:
                      [
                        year1,
                        year2,
                        year3,
                        year4,
                      ].reduce((a, b) => a > b ? a : b).toDouble() +
                      5,
                  barGroups: [
                    BarChartGroupData(
                      x: 1,
                      barRods: [BarChartRodData(toY: year1.toDouble())],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [BarChartRodData(toY: year2.toDouble())],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [BarChartRodData(toY: year3.toDouble())],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [BarChartRodData(toY: year4.toDouble())],
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
