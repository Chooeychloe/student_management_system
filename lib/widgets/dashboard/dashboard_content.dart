import 'package:flutter/material.dart';

import '../student_table.dart';
import 'dashboard_statistics.dart';
import 'search_toolbar.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Dashboard",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 24),

          DashboardStatistics(),

          SizedBox(height: 20),

          SearchToolbar(),

          SizedBox(height: 20),

          Expanded(
            child: Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: StudentTable(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
