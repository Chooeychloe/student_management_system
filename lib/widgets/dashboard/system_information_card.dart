import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/student_provider.dart';

class SystemInformationCard extends StatelessWidget {
  const SystemInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "System Information",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text("Database"),
              trailing: const Text("SQLite"),
            ),

            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Total Students"),
              trailing: Text(provider.totalStudents.toString()),
            ),

            ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Courses"),
              trailing: const Text("4"),
            ),

            ListTile(
              leading: const Icon(Icons.verified),
              title: const Text("Status"),
              trailing: const Chip(label: Text("Healthy")),
            ),
          ],
        ),
      ),
    );
  }
}
