import 'package:flutter/material.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  _action(Icons.person_add, "Add Student"),
                  _action(Icons.upload_file, "Import CSV"),
                  _action(Icons.download, "Export CSV"),
                  _action(Icons.backup, "Backup Database"),
                  _action(Icons.refresh, "Refresh"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _action(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FilledButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(title),
      ),
    );
  }
}
