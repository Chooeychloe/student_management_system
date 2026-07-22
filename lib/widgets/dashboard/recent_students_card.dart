import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/student_provider.dart';

class RecentStudentsCard extends StatelessWidget {
  const RecentStudentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    final students = provider.students.reversed.take(5).toList();

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recently Added Students",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            if (students.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text("No students found."),
                ),
              ),

            ...students.map(
              (student) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text("${student.firstName} ${student.lastName}"),
                subtitle: Text(student.studentNumber),
                trailing: Text(student.course),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
