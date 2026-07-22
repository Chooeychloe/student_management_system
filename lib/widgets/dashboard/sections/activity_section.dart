import 'package:flutter/material.dart';

import '../recent_activity_card.dart';
import '../system_information_card.dart';

class ActivitySection extends StatelessWidget {
  const ActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(child: RecentActivityCard()),

        SizedBox(width: 20),

        Expanded(child: SystemInformationCard()),
      ],
    );
  }
}
