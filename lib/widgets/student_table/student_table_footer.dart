import 'package:flutter/material.dart';
import 'package:student_management_system/providers/student_provider.dart';

class StudentTableFooter extends StatelessWidget {
  final StudentProvider provider;

  const StudentTableFooter({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "Showing ${provider.paginatedStudents.length} of ${provider.filteredStudents.length}",
          ),

          const Spacer(),

          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: provider.currentPage == 1 ? null : provider.previousPage,
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
    );
  }
}
