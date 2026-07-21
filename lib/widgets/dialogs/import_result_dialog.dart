import 'package:flutter/material.dart';

import '../../models/import_result.dart';

class ImportResultDialog extends StatelessWidget {
  final ImportResult result;

  const ImportResultDialog({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Import Completed"),

      content: SizedBox(
        width: 600,
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    _buildRow(
                      Icons.check_circle,
                      Colors.green,
                      "Imported",
                      result.imported,
                    ),

                    const SizedBox(height: 10),

                    _buildRow(
                      Icons.warning,
                      Colors.orange,
                      "Duplicates",
                      result.duplicates,
                    ),

                    const SizedBox(height: 10),

                    _buildRow(
                      Icons.cancel,
                      Colors.red,
                      "Invalid",
                      result.invalid,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Validation Errors",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 10),

            Expanded(
              child:
                  result.errors.isEmpty
                      ? const Center(
                        child: Text(
                          "No errors found.",
                          style: TextStyle(color: Colors.green),
                        ),
                      )
                      : ListView.builder(
                        itemCount: result.errors.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            dense: true,
                            leading: const Icon(Icons.error, color: Colors.red),
                            title: Text(result.errors[index]),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),

      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }

  Widget _buildRow(IconData icon, Color color, String label, int value) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Expanded(child: Text(label)),
        Text(
          value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
