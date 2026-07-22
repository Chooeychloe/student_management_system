import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Dashboard",
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 6),

        Text(
          "Welcome back! Here's an overview of your Student Management System.",
          style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
        ),
      ],
    );
  }
}
