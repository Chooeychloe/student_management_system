import 'package:flutter/material.dart';

import '../../models/student.dart';

class StudentProfileDialog extends StatelessWidget {
  final Student student;

  const StudentProfileDialog({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Student Profile",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),

      content: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                child: Text(
                  "${student.firstName[0]}${student.lastName[0]}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              _infoTile("Student Number", student.studentNumber),

              _infoTile("First Name", student.firstName),

              _infoTile("Middle Name", student.middleName),

              _infoTile("Last Name", student.lastName),

              _infoTile("Course", student.course),

              _infoTile("Year Level", student.yearLevel.toString()),

              _infoTile("Email", student.email),

              _infoTile("Contact Number", student.contactNumber),

              _infoTile("Address", student.address),
            ],
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 4),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value.isEmpty ? "-" : value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
