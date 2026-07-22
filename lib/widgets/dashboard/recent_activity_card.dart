import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/activity_provider.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActivityProvider>();

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Activities",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            if (provider.recentActivities.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: Text("No activities yet.")),
              )
            else
              ...provider.recentActivities.map(
                (activity) => ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.history)),
                  title: Text(activity.title),
                  subtitle: Text(activity.description),
                  trailing: Text(
                    "${activity.timestamp.hour.toString().padLeft(2, '0')}:"
                    "${activity.timestamp.minute.toString().padLeft(2, '0')}",
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
