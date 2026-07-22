import 'package:flutter/material.dart';
import 'package:student_management_system/providers/student_provider.dart';

class StudentTableHeader extends StatelessWidget {
  final StudentProvider provider;

  const StudentTableHeader({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final pageStudents = provider.paginatedStudents;

    final selectedCount =
        pageStudents
            .where((student) => provider.isSelected(student.id!))
            .length;

    final allSelected =
        pageStudents.isNotEmpty && selectedCount == pageStudents.length;

    final partiallySelected =
        selectedCount > 0 && selectedCount < pageStudents.length;
    return Container(
      height: 55,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 45,
            child: Checkbox(
              tristate: true,
              value:
                  allSelected
                      ? true
                      : partiallySelected
                      ? null
                      : false,
              onChanged: (value) {
                provider.toggleSelectAll(pageStudents, value ?? false);
              },
            ),
          ),

          Expanded(
            flex: 2,
            child: _sortableTitle(
              "Student No.",
              () => provider.sortByStudentNumber(),
            ),
          ),

          Expanded(
            flex: 4,
            child: _sortableTitle("Name", () => provider.sortByName()),
          ),

          Expanded(
            flex: 2,
            child: _sortableTitle("Course", () => provider.sortByCourse()),
          ),

          Expanded(
            flex: 1,
            child: _sortableTitle("Year", () => provider.sortByYear()),
          ),

          const Expanded(
            flex: 3,
            child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          const Expanded(
            flex: 2,
            child: Text(
              "Contact",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const Expanded(
            flex: 2,
            child: Center(
              child: Text(
                "Actions",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sortableTitle(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

          const Icon(Icons.unfold_more, size: 18),
        ],
      ),
    );
  }
}
