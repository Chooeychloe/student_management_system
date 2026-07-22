import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/providers/activity_provider.dart';
import 'package:student_management_system/widgets/dialogs/delete_confirmation_dialog.dart';
import 'package:student_management_system/widgets/dialogs/student_profile_dialog.dart';

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
              _buildHeader(),

              const Divider(height: 1),

              Expanded(
                child: ListView.separated(
                  itemCount: provider.paginatedStudents.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final student = provider.paginatedStudents[index];

                    return _buildRow(context, provider, student);
                  },
                ),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Showing ${provider.paginatedStudents.length} of ${provider.filteredStudents.length}",
                    ),

                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed:
                          provider.currentPage == 1
                              ? null
                              : provider.previousPage,
                    ),

                    Text("${provider.currentPage} / ${provider.totalPages}"),

                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed:
                          provider.currentPage == provider.totalPages
                              ? null
                              : provider.nextPage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.grey.shade100,
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Student No.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            flex: 4,
            child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          Expanded(
            flex: 2,
            child: Text(
              "Course",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            flex: 1,
            child: Text("Year", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          Expanded(
            flex: 2,
            child: Text(
              "Contact",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                "Actions",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    StudentProvider provider,
    Student student,
  ) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(student.studentNumber)),

          Expanded(
            flex: 4,
            child: Text("${student.firstName} ${student.lastName}"),
          ),

          Expanded(flex: 2, child: Text(student.course)),

          Expanded(flex: 1, child: Text(student.yearLevel.toString())),
          Expanded(flex: 3, child: Text(student.email)),

          Expanded(flex: 2, child: Text(student.contactNumber)),

          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: "View",
                  icon: const Icon(Icons.visibility, color: Colors.blue),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => StudentProfileDialog(student: student),
                    );
                  },
                ),
                IconButton(
                  tooltip: "Edit",
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => StudentFormDialog(student: student),
                    );
                  },
                ),

                IconButton(
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
                                  content: Text(
                                    "Student deleted successfully.",
                                  ),
                                ),
                              );
                            },
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
