import 'package:flutter/material.dart';

import '../../models/student.dart';

class RecentStudentTile extends StatelessWidget {
  final Student student;

  const RecentStudentTile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(student.firstName[0])),

      title: Text(
        "${student.firstName} ${student.lastName}",
        overflow: TextOverflow.ellipsis,
      ),

      subtitle: Text("${student.studentNumber}\n${student.course}"),

      trailing: IconButton(
        icon: const Icon(Icons.visibility),
        onPressed: () {},
      ),
    );
  }
}
