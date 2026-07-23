import 'package:flutter/material.dart';
import 'package:student_management_system/providers/student_provider.dart';

class StudentTableFooter extends StatelessWidget {
  final StudentProvider provider;

  const StudentTableFooter({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Text(
            "Showing ${provider.startRecord}–${provider.endRecord} of ${provider.filteredStudents.length} students",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),

          const Spacer(),

          IconButton(
            tooltip: "First Page",
            icon: const Icon(Icons.first_page),
            onPressed: provider.currentPage == 1 ? null : provider.firstPage,
          ),

          IconButton(
            tooltip: "Previous Page",
            icon: const Icon(Icons.chevron_left),
            onPressed: provider.currentPage == 1 ? null : provider.previousPage,
          ),

          ...provider.visiblePages.map((page) {
            final selected = page == provider.currentPage;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(42, 42),
                    backgroundColor:
                        selected ? Colors.indigo : Colors.grey.shade200,
                    foregroundColor: selected ? Colors.white : Colors.black,
                    elevation: selected ? 3 : 0,
                  ),
                  onPressed: () => provider.goToPage(page),
                  child: Text(page.toString()),
                ),
              ),
            );
          }),

          IconButton(
            tooltip: "Next Page",
            icon: const Icon(Icons.chevron_right),
            onPressed:
                provider.currentPage == provider.totalPages
                    ? null
                    : provider.nextPage,
          ),

          IconButton(
            tooltip: "Last Page",
            icon: const Icon(Icons.last_page),
            onPressed:
                provider.currentPage == provider.totalPages
                    ? null
                    : provider.lastPage,
          ),

          const SizedBox(width: 20),

          const Text("Rows"),

          const SizedBox(width: 8),

          SizedBox(
            width: 90,
            child: DropdownButtonFormField<int>(
              value: provider.rowsPerPage,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 10, child: Text("10")),
                DropdownMenuItem(value: 25, child: Text("25")),
                DropdownMenuItem(value: 50, child: Text("50")),
                DropdownMenuItem(value: 100, child: Text("100")),
              ],
              onChanged: (value) {
                if (value != null) {
                  provider.setRowsPerPage(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
