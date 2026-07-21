import 'package:flutter/material.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  bool darkMode = false;
  bool openLastPage = true;
  bool confirmDelete = true;

  int rowsPerPage = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 800,
            child: Column(
              children: [
                /// Appearance
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Appearance",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        SwitchListTile(
                          value: darkMode,
                          onChanged: (value) {
                            setState(() {
                              darkMode = value;
                            });
                          },
                          title: const Text("Dark Mode"),
                          subtitle: const Text(
                            "Enable dark theme (Coming Soon)",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Table Settings
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Student Table",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Rows Per Page",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),

                            DropdownButton<int>(
                              value: rowsPerPage,
                              items: const [
                                DropdownMenuItem(value: 5, child: Text("5")),

                                DropdownMenuItem(value: 10, child: Text("10")),

                                DropdownMenuItem(value: 15, child: Text("15")),

                                DropdownMenuItem(value: 20, child: Text("20")),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    rowsPerPage = value;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Application
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Application",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        SwitchListTile(
                          value: openLastPage,
                          onChanged: (value) {
                            setState(() {
                              openLastPage = value;
                            });
                          },
                          title: const Text("Open Last Screen on Startup"),
                        ),

                        SwitchListTile(
                          value: confirmDelete,
                          onChanged: (value) {
                            setState(() {
                              confirmDelete = value;
                            });
                          },
                          title: const Text("Confirm Before Deleting"),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// System Information
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "System Information",
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
                          leading: Icon(Icons.desktop_windows),
                          title: Text("Framework"),
                          subtitle: Text("Flutter Desktop"),
                        ),

                        ListTile(
                          leading: Icon(Icons.info_outline),
                          title: Text("Version"),
                          subtitle: Text("1.0.0"),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Save Settings"),
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
