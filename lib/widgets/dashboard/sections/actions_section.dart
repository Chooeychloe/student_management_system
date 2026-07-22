import 'package:flutter/material.dart';

import '../quick_actions_card.dart';
import '../recent_students_card.dart';

class ActionsSection extends StatelessWidget {
  const ActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(flex: 4, child: QuickActionsCard()),

        SizedBox(width: 20),

        Expanded(flex: 6, child: RecentStudentsCard()),
      ],
    );
  }
}
