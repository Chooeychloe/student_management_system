import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/student.dart';
import '../../providers/activity_provider.dart';
import '../../providers/student_provider.dart';
import '../dialogs/delete_confirmation_dialog.dart';
import '../dialogs/student_form_dialog.dart';
import '../dialogs/student_profile_dialog.dart';

class StudentActions extends StatelessWidget {
  final Student student;

  const StudentActions({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tooltip(
          message: "View Student",

          child: IconButton(
            tooltip: "View",
            icon: const Icon(Icons.visibility, color: Colors.blue),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => StudentProfileDialog(student: student),
              );
            },
          ),
        ),

        Tooltip(
          message: "Edit Student",

          child: IconButton(
            tooltip: "Edit",
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => StudentFormDialog(student: student),
              );
            },
          ),
        ),

        Tooltip(
          message: "Delete Student",

          child: IconButton(
            tooltip: "Delete",
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (_) => DeleteConfirmationDialog(
                      title: "Delete Student",
                      message:
                          "Are you sure you want to delete "
                          "${student.firstName} ${student.lastName}?\n\n"
                          "This action cannot be undone.",
                      onConfirm: () async {
                        final provider = context.read<StudentProvider>();
                        final activityProvider =
                            context.read<ActivityProvider>();
                        final messenger = ScaffoldMessenger.of(context);

                        await provider.deleteStudent(student.id!);

                        activityProvider.addActivity(
                          title: "Student Deleted",
                          description:
                              "${student.firstName} ${student.lastName} (${student.studentNumber}) was deleted.",
                        );

                        if (!context.mounted) return;

                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text("Student deleted successfully."),
                          ),
                        );
                      },
                    ),
              );
            },
          ),
        ),
      ],
    );
  }
}
