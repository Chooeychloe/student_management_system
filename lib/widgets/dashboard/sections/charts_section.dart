import 'package:flutter/material.dart';
import 'package:student_management_system/widgets/dashboard/charts/course_pie_chart.dart';
import 'package:student_management_system/widgets/dashboard/charts/year_bar_chart.dart';

class ChartsSection extends StatelessWidget {
  const ChartsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(child: CoursePieChart()),

        SizedBox(width: 20),

        Expanded(child: YearBarChart()),
      ],
    );
  }
}
