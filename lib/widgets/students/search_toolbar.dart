import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/providers/activity_provider.dart';
import 'package:student_management_system/services/export_service.dart';
import 'package:student_management_system/services/import_service.dart';
import 'package:student_management_system/widgets/dialogs/import_result_dialog.dart';

import '../../core/constants.dart';
import '../../providers/student_provider.dart';
import '../dialogs/student_form_dialog.dart';

class SearchToolbar extends StatelessWidget {
  const SearchToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 15,
          runSpacing: 15,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 320,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search student...",
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: provider.searchStudents,
              ),
            ),

            SizedBox(
              width: 180,
              child: DropdownButtonFormField<String>(
                value: provider.selectedCourse,
                decoration: const InputDecoration(labelText: "Course"),
                items: [
                  const DropdownMenuItem(value: "All", child: Text("All")),
                  ...AppConstants.courses.map(
                    (course) =>
                        DropdownMenuItem(value: course, child: Text(course)),
                  ),
                ],
                onChanged: provider.filterByCourse,
              ),
            ),

            SizedBox(
              width: 150,
              child: DropdownButtonFormField<int?>(
                value: provider.selectedYear,
                decoration: const InputDecoration(labelText: "Year"),
                items: const [
                  DropdownMenuItem(value: null, child: Text("All")),
                  DropdownMenuItem(value: 1, child: Text("1")),
                  DropdownMenuItem(value: 2, child: Text("2")),
                  DropdownMenuItem(value: 3, child: Text("3")),
                  DropdownMenuItem(value: 4, child: Text("4")),
                ],
                onChanged: provider.filterByYear,
              ),
            ),

            ElevatedButton.icon(
              onPressed: provider.loadStudents,
              icon: const Icon(Icons.refresh),
              label: const Text("Refresh"),
            ),

            FilledButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const StudentFormDialog(),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Student"),
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text("Export CSV"),
              onPressed: () async {
                final provider = context.read<StudentProvider>();
                final activityProvider = context.read<ActivityProvider>();
                final messenger = ScaffoldMessenger.of(context);

                final success = await ExportService().exportStudentsToCSV(
                  provider.filteredStudents,
                );

                activityProvider.addActivity(
                  title: "CSV Exported",
                  description:
                      "${provider.filteredStudents.length} student records exported.",
                );

                if (!context.mounted) return;

                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? "CSV exported successfully."
                          : "Export cancelled.",
                    ),
                  ),
                );
              },
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text("Import CSV"),
              onPressed: () async {
                final studentProvider = context.read<StudentProvider>();
                final activityProvider = context.read<ActivityProvider>();

                final result = await ImportService().importStudentsFromCSV();

                await studentProvider.loadStudents();

                activityProvider.addActivity(
                  title: "CSV Imported",
                  description:
                      "${result.imported} students imported, "
                      "${result.duplicates} duplicates skipped, "
                      "${result.invalid} invalid rows.",
                );

                if (!context.mounted) return;

                showDialog(
                  context: context,
                  builder: (_) => ImportResultDialog(result: result),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
