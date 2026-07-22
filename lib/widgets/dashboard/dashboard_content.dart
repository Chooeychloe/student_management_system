import 'package:flutter/material.dart';

import 'dashboard_header.dart';
import 'dashboard_statistics.dart';

import 'sections/actions_section.dart';
import 'sections/charts_section.dart';
import 'sections/activity_section.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          DashboardHeader(),

          SizedBox(height: 24),

          DashboardStatistics(),

          SizedBox(height: 24),

          ActionsSection(),

          SizedBox(height: 24),

          ChartsSection(),

          SizedBox(height: 24),

          ActivitySection(),
        ],
      ),
    );
  }
}
