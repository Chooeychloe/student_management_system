import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/student_provider.dart';

class CoursePieChart extends StatelessWidget {
  const CoursePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    final total = provider.totalStudents;

    if (total == 0) {
      return const Card(
        child: Center(child: Text("No student data available.")),
      );
    }

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Students per Course",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 50,
                  sectionsSpace: 3,
                  sections: [
                    PieChartSectionData(
                      value: provider.totalBSCS.toDouble(),
                      title: provider.totalBSCS.toString(),
                      color: Colors.blue,
                      radius: 70,
                    ),

                    PieChartSectionData(
                      value: provider.totalBSIT.toDouble(),
                      title: provider.totalBSIT.toString(),
                      color: Colors.orange,
                      radius: 70,
                    ),

                    PieChartSectionData(
                      value: provider.totalBSIS.toDouble(),
                      title: provider.totalBSIS.toString(),
                      color: Colors.green,
                      radius: 70,
                    ),

                    PieChartSectionData(
                      value: provider.totalBSEMC.toDouble(),
                      title: provider.totalBSEMC.toString(),
                      color: Colors.red,
                      radius: 70,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: const [
                _Legend(Colors.blue, "BSCS"),
                _Legend(Colors.orange, "BSIT"),
                _Legend(Colors.green, "BSIS"),
                _Legend(Colors.red, "BSEMC"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String title;

  const _Legend(this.color, this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),

        const SizedBox(width: 8),

        Text(title),
      ],
    );
  }
}
