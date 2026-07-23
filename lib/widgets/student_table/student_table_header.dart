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
        mainAxisSize: MainAxisSize.min,

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
              title: "Student No.",
              field: "studentNumber",
              onTap: provider.sortByStudentNumber,
            ),
          ),

          Expanded(
            flex: 4,
            child: _sortableTitle(
              title: "Student Name",
              field: "name",
              onTap: provider.sortByName,
            ),
          ),

          Expanded(
            flex: 2,
            child: _sortableTitle(
              title: "Course",
              field: "course",
              onTap: provider.sortByCourse,
            ),
          ),

          Expanded(
            flex: 1,
            child: _sortableTitle(
              title: "Year",
              field: "year",
              onTap: provider.sortByYear,
            ),
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

  Widget _sortableTitle({
    required String title,
    required String field,
    required VoidCallback onTap,
  }) {
    IconData icon = Icons.unfold_more;

    if (provider.sortField == field) {
      icon =
          provider.sortAscending
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          hoverColor: Colors.indigo.withValues(alpha: 0.08),
          splashColor: Colors.indigo.withValues(alpha: 0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 4),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  transitionBuilder:
                      (child, animation) =>
                          RotationTransition(turns: animation, child: child),
                  child: Icon(icon, key: ValueKey(icon), size: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
