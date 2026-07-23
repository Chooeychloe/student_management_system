import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/activity_provider.dart';
import '../../providers/student_provider.dart';
import '../dialogs/delete_confirmation_dialog.dart';

class StudentTableActions extends StatelessWidget {
  const StudentTableActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (_, provider, __) {
        if (!provider.hasSelection) {
          return const SizedBox.shrink();
        }

        return Card(
          color: Colors.indigo.shade50,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.indigo.shade700),

                const SizedBox(width: 12),

                Text(
                  "${provider.selectedStudents.length} student(s) selected",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const Spacer(),

                FilledButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete Selected"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => DeleteConfirmationDialog(
                            title: "Delete Students",
                            message:
                                "Delete ${provider.selectedStudents.length} selected students?\n\n"
                                "This action cannot be undone.",
                            onConfirm: () async {
                              final messenger = ScaffoldMessenger.of(context);

                              final activity = context.read<ActivityProvider>();

                              final count = provider.selectedStudents.length;

                              await provider.deleteSelectedStudents();

                              activity.addActivity(
                                title: "Bulk Delete",
                                description: "$count students were deleted.",
                              );

                              if (!context.mounted) return;

                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "$count students deleted successfully.",
                                  ),
                                ),
                              );
                            },
                          ),
                    );
                  },
                ),

                const SizedBox(width: 10),

                OutlinedButton.icon(
                  icon: const Icon(Icons.clear),
                  label: const Text("Clear"),
                  onPressed: provider.clearSelection,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
