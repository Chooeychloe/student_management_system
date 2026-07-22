import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/models/student.dart';
import 'package:student_management_system/providers/student_provider.dart';
import 'package:student_management_system/widgets/dialogs/student_profile_dialog.dart';
import 'package:student_management_system/widgets/student_table/student_actions.dart';

class StudentTableRow extends StatelessWidget {
  final Student student;

  const StudentTableRow({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onDoubleTap: () {
          showDialog(
            context: context,
            builder: (_) => StudentProfileDialog(student: student),
          );
        },
        child: InkWell(
          onTap: () {
            provider.toggleSelection(student.id!);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color:
                provider.isSelected(student.id!)
                    ? Colors.blue.shade50
                    : Colors.transparent,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 45,
                  child: Checkbox(
                    value: provider.isSelected(student.id!),
                    onChanged: (_) {
                      provider.toggleSelection(student.id!);
                    },
                  ),
                ),

                Expanded(flex: 2, child: Text(student.studentNumber)),

                Expanded(flex: 4, child: Text(student.fullName)),

                Expanded(flex: 2, child: Text(student.course)),

                Expanded(flex: 1, child: Text("${student.yearLevel}")),

                Expanded(flex: 3, child: Text(student.email)),

                Expanded(flex: 2, child: Text(student.contactNumber)),

                Expanded(flex: 2, child: StudentActions(student: student)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
