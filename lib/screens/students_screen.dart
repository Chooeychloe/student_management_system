import 'package:flutter/material.dart';

import '../widgets/students/search_toolbar.dart';
import '../widgets/students/student_table.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Students",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 24),

          SearchToolbar(),

          SizedBox(height: 20),

          Expanded(child: StudentTable()),
        ],
      ),
    );
  }
}
