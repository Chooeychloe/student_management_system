import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/student_provider.dart';

class RecentStudentsCard extends StatelessWidget {
  const RecentStudentsCard({super.key});

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
              "Recent Students",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.separated(
                itemCount: provider.recentStudents.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, index) {
                  final student = provider.recentStudents[index];

                  return ListTile(
                    leading: CircleAvatar(child: Text(student.firstName[0])),

                    title: Text("${student.firstName} ${student.lastName}"),

                    subtitle: Text(
                      "${student.course} • Year ${student.yearLevel}",
                    ),

                    trailing: Text(student.studentNumber),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
