import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/providers/student_provider.dart';

class CoursePieChart extends StatelessWidget {
  const CoursePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Students by Course",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 280,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 45,
                  sectionsSpace: 3,
                  sections: [
                    PieChartSectionData(
                      value: provider.totalBSCS.toDouble(),
                      color: Colors.blue,
                      title: "BSCS",
                    ),
                    PieChartSectionData(
                      value: provider.totalBSIT.toDouble(),
                      color: Colors.orange,
                      title: "BSIT",
                    ),
                    PieChartSectionData(
                      value: provider.totalBSIS.toDouble(),
                      color: Colors.green,
                      title: "BSIS",
                    ),
                    PieChartSectionData(
                      value: provider.totalBSEMC.toDouble(),
                      color: Colors.red,
                      title: "BSEMC",
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
