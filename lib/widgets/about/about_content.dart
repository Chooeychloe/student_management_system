import 'package:flutter/material.dart';
import '../../core/constants.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("About"), centerTitle: false),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 700,
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const Icon(
                      Icons.school_rounded,
                      size: 90,
                      color: Colors.indigo,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      AppConstants.appName,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Version 1.0.0",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.desktop_windows),
                      title: const Text("Framework"),
                      subtitle: const Text("Flutter Desktop"),
                    ),

                    ListTile(
                      leading: const Icon(Icons.storage),
                      title: const Text("Database"),
                      subtitle: const Text("SQLite"),
                    ),

                    ListTile(
                      leading: const Icon(Icons.palette),
                      title: const Text("UI Framework"),
                      subtitle: const Text("Material Design 3"),
                    ),

                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text("Developer"),
                      subtitle: const Text("Dhan Belgica"),
                    ),

                    ListTile(
                      leading: const Icon(Icons.copyright),
                      title: const Text("Copyright"),
                      subtitle: const Text("© 2026 All Rights Reserved"),
                    ),

                    const Divider(height: 40),

                    const Text(
                      "Student Management System is a desktop application "
                      "designed to manage student records using Flutter "
                      "Desktop and SQLite. This application demonstrates "
                      "responsive desktop design, local database management, "
                      "and clean software architecture.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),

                    const SizedBox(height: 30),

                    FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Back"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
