import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/student_provider.dart';

class BulkActionToolbar extends StatelessWidget {
  const BulkActionToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    if (provider.selectedStudents.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Text(
              "${provider.selectedStudents.length} selected",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            FilledButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text("Delete Selected"),
              onPressed: () async {
                await provider.deleteSelectedStudents();
              },
            ),

            const SizedBox(width: 10),

            OutlinedButton(
              onPressed: provider.clearSelection,
              child: const Text("Clear"),
            ),
          ],
        ),
      ),
    );
  }
}
