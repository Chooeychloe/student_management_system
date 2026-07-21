import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/student_provider.dart';
import 'statistic_card.dart';

class DashboardStatistics extends StatelessWidget {
  const DashboardStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (_, provider, __) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final cards = [
              StatisticCard(
                title: "Total Students",
                value: provider.totalStudents.toString(),
                icon: Icons.people,
                color: Colors.blue,
              ),
              StatisticCard(
                title: "BSCS",
                value: provider.totalBSCS.toString(),
                icon: Icons.computer,
                color: Colors.green,
              ),
              StatisticCard(
                title: "BSIT",
                value: provider.totalBSIT.toString(),
                icon: Icons.laptop,
                color: Colors.orange,
              ),
              StatisticCard(
                title: "BSIS",
                value: provider.totalBSIS.toString(),
                icon: Icons.storage,
                color: Colors.purple,
              ),
            ];

            if (constraints.maxWidth > 950) {
              return Row(
                children:
                    cards
                        .map(
                          (card) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: card,
                            ),
                          ),
                        )
                        .toList(),
              );
            }

            return Wrap(
              spacing: 15,
              runSpacing: 15,
              children:
                  cards
                      .map((card) => SizedBox(width: 280, child: card))
                      .toList(),
            );
          },
        );
      },
    );
  }
}
