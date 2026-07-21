import 'package:flutter/material.dart';

class BackupRestoreContent extends StatefulWidget {
  const BackupRestoreContent({super.key});

  @override
  State<BackupRestoreContent> createState() => _BackupRestoreContentState();
}

class _BackupRestoreContentState extends State<BackupRestoreContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("Backup & Restore")),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 850,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Database Information
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Database Information",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20),

                        ListTile(
                          leading: Icon(Icons.storage),
                          title: Text("Database"),
                          subtitle: Text("SQLite"),
                        ),

                        ListTile(
                          leading: Icon(Icons.folder),
                          title: Text("Database Location"),
                          subtitle: Text("C:\\StudentManagement\\student.db"),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Backup Actions
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Backup & Restore",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 25),

                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            FilledButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Backup feature coming soon.",
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.backup),
                              label: const Text("Backup Database"),
                            ),

                            FilledButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Restore feature coming soon.",
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.restore),
                              label: const Text("Restore Database"),
                            ),

                            OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Open folder feature coming soon.",
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.folder_open),
                              label: const Text("Open Folder"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Backup History
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Backup History",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20),

                        ListTile(
                          leading: Icon(Icons.history),
                          title: Text("No backups available."),
                          subtitle: Text("Create your first database backup."),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Center(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Back"),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
