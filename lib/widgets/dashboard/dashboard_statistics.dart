import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/student_provider.dart';
import 'statistic_card.dart';

class DashboardStatistics extends StatelessWidget {
  const DashboardStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    return SizedBox(
      height: 150,
      child: Row(
        children: [
          Expanded(
            child: StatisticCard(
              icon: Icons.people,
              color: Colors.indigo,
              title: "Students",
              value: provider.totalStudents,
              subtitle: "Registered",
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: StatisticCard(
              icon: Icons.computer,
              color: Colors.blue,
              title: "BSCS",
              value: provider.totalBSCS,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: StatisticCard(
              icon: Icons.laptop,
              color: Colors.orange,
              title: "BSIT",
              value: provider.totalBSIT,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: StatisticCard(
              icon: Icons.storage,
              color: Colors.green,
              title: "BSIS",
              value: provider.totalBSIS,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: StatisticCard(
              icon: Icons.games,
              color: Colors.red,
              title: "BSEMC",
              value: provider.totalBSEMC,
            ),
          ),
        ],
      ),
    );
  }
}
