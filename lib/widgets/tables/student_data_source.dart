import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/student.dart';
import '../../providers/student_provider.dart';
import '../dialogs/student_form_dialog.dart';

class StudentDataSource extends DataTableSource {
  final BuildContext context;
  final List<Student> students;

  StudentDataSource({required this.context, required this.students});

  @override
  DataRow? getRow(int index) {
    if (index >= students.length) return null;

    final student = students[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(student.studentNumber)),

        DataCell(Text("${student.firstName} ${student.lastName}")),

        DataCell(Text(student.course)),

        DataCell(Text(student.yearLevel.toString())),

        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: "Edit Student",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => StudentFormDialog(student: student),
                  );
                },
              ),

              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: "Delete Student",
                onPressed: () async {
                  final delete = await showDialog<bool>(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: const Text("Delete Student"),
                          content: Text(
                            "Delete ${student.firstName} ${student.lastName}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text("Cancel"),
                            ),
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                  );

                  if (delete == true) {
                    await context.read<StudentProvider>().deleteStudent(
                      student.id!,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => students.length;

  @override
  int get selectedRowCount => 0;
}
