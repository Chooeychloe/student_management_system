import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/providers/recent_students_provider.dart';
import 'package:student_management_system/widgets/dashboard/recent_students_tile.dart';

class RecentStudents extends StatelessWidget {
  const RecentStudents({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecentStudentsProvider>();

    final students = provider.recentStudents;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Recent Students",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const Divider(),

            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder:
                    (_, index) => RecentStudentTile(student: students[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
