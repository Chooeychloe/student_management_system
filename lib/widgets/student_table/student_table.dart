import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/providers/activity_provider.dart';
import 'package:student_management_system/widgets/dialogs/delete_confirmation_dialog.dart';
import 'package:student_management_system/widgets/dialogs/student_profile_dialog.dart';
import 'package:student_management_system/widgets/student_table/student_table_footer.dart';
import 'package:student_management_system/widgets/student_table/student_table_header.dart';
import 'package:student_management_system/widgets/student_table/student_table_row.dart';

import '../../models/student.dart';
import '../../providers/student_provider.dart';
import '../dialogs/student_form_dialog.dart';
import '../common/loading_indicator.dart';

class StudentTable extends StatelessWidget {
  const StudentTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const LoadingIndicator();
        }

        if (provider.filteredStudents.isEmpty) {
          return const Center(
            child: Text("No students found.", style: TextStyle(fontSize: 18)),
          );
        }

        return Card(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              StudentTableHeader(provider: provider),

              const Divider(height: 1),

              Expanded(
                child: ListView.separated(
                  itemCount: provider.paginatedStudents.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final student = provider.paginatedStudents[index];

                    return StudentTableRow(student: student);
                  },
                ),
              ),
              StudentTableFooter(provider: provider),
            ],
          ),
        );
      },
    );
  }
}
