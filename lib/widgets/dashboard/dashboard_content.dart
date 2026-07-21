import 'package:flutter/material.dart';
import 'package:student_management_system/widgets/dashboard/quick_actions_card.dart';
import 'package:student_management_system/widgets/dashboard/recent_students_card.dart';

import 'dashboard_statistics.dart';
import 'course_pie_chart.dart';
import 'year_bar_chart.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dashboard",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 25),

          DashboardStatistics(),

          // SizedBox(height: 25),

          // Expanded(
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Expanded(flex: 2, child: CoursePieChart()),

          //       SizedBox(width: 20),

          //       Expanded(flex: 2, child: YearBarChart()),
          //     ],
          //   ),
          // ),
          SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                Expanded(flex: 2, child: QuickActionsCard()),

                SizedBox(width: 20),

                Expanded(flex: 3, child: RecentStudentsCard()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
