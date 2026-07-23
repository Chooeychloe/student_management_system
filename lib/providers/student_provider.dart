import 'package:flutter/material.dart';

import '../database/student_repository.dart';
import '../models/student.dart';

class StudentProvider extends ChangeNotifier {
  final StudentRepository _repository = StudentRepository();
  // Sorting
  String? _sortField;
  bool _sortAscending = true;

  String? get sortField => _sortField;
  bool get sortAscending => _sortAscending;
  final List<Student> _students = [];
  List<Student> _filteredStudents = [];
  final Set<int> _selectedStudents = {};
  int get selectedCount => _selectedStudents.length;
  Set<int> get selectedStudents => _selectedStudents;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Student> get students => List.unmodifiable(_students);

  List<Student> get filteredStudents => List.unmodifiable(_filteredStudents);
  int get startRecord =>
      _filteredStudents.isEmpty ? 0 : ((_currentPage - 1) * _rowsPerPage) + 1;

  int get endRecord {
    final end = _currentPage * _rowsPerPage;
    return end > _filteredStudents.length ? _filteredStudents.length : end;
  }

  // Search & Filter
  String searchText = "";
  String selectedCourse = "All";
  int? selectedYear;

  // Pagination
  int _currentPage = 1;
  int _rowsPerPage = 10;

  int get currentPage => _currentPage;

  int get rowsPerPage => _rowsPerPage;

  int get totalStudents => _students.length;

  int get totalPages {
    if (_filteredStudents.isEmpty) return 1;

    return (_filteredStudents.length / _rowsPerPage).ceil();
  }

  void firstPage() {
    _currentPage = 1;
    notifyListeners();
  }

  void lastPage() {
    _currentPage = totalPages;
    notifyListeners();
  }

  List<int> get visiblePages {
    const window = 2;

    int start = _currentPage - window;
    int end = _currentPage + window;

    if (start < 1) {
      end += 1 - start;
      start = 1;
    }

    if (end > totalPages) {
      start -= end - totalPages;
      end = totalPages;
    }

    if (start < 1) start = 1;

    return List.generate(end - start + 1, (index) => start + index);
  }

  List<Student> get selectedStudentsList {
    return _filteredStudents
        .where((student) => _selectedStudents.contains(student.id))
        .toList();
  }

  void setRowsPerPage(int rows) {
    _rowsPerPage = rows;
    _currentPage = 1;
    notifyListeners();
  }

  void _sortStudents<T extends Comparable>(
    Comparable Function(Student student) selector,
    String field,
  ) {
    if (_sortField == field) {
      _sortAscending = !_sortAscending;
    } else {
      _sortField = field;
      _sortAscending = true;
    }

    _filteredStudents.sort((a, b) {
      final result = selector(a).compareTo(selector(b));
      return _sortAscending ? result : -result;
    });

    notifyListeners();
  }

  List<Student> get paginatedStudents {
    if (_filteredStudents.isEmpty) return [];

    final start = (_currentPage - 1) * _rowsPerPage;

    if (start >= _filteredStudents.length) return [];

    final end = start + _rowsPerPage;

    return _filteredStudents.sublist(
      start,
      end > _filteredStudents.length ? _filteredStudents.length : end,
    );
  }

  Future<void> loadStudents() async {
    _isLoading = true;
    notifyListeners();

    final students = await _repository.getStudents();

    _students
      ..clear()
      ..addAll(students);

    _refreshFilteredStudents();
    _selectedStudents.clear();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addStudent(Student student) async {
    await _repository.addStudent(student);
    await loadStudents();
  }

  Future<void> updateStudent(Student student) async {
    await _repository.updateStudent(student);
    await loadStudents();
  }

  Future<void> deleteStudent(int id) async {
    await _repository.deleteStudent(id);
    await loadStudents();
  }

  bool isSelected(int id) => selectedStudents.contains(id);
  void toggleSelection(int id) {
    if (selectedStudents.contains(id)) {
      selectedStudents.remove(id);
    } else {
      selectedStudents.add(id);
    }

    notifyListeners();
  }

  void sortByStudentNumber() =>
      _sortStudents((s) => s.studentNumber, "studentNumber");

  void sortByName() => _sortStudents((s) => s.fullName, "name");

  void sortByCourse() => _sortStudents((s) => s.course, "course");

  void sortByYear() => _sortStudents((s) => s.yearLevel, "year");

  void clearSelection() {
    selectedStudents.clear();
    notifyListeners();
  }

  bool get hasSelection => selectedStudents.isNotEmpty;
  bool get allSelected {
    if (_filteredStudents.isEmpty) return false;

    return _selectedStudents.length == _filteredStudents.length;
  }

  void toggleSelectAll(List<Student> paginatedStudents, bool bool) {
    if (allSelected) {
      _selectedStudents.clear();
    } else {
      _selectedStudents
        ..clear()
        ..addAll(
          _filteredStudents
              .where((student) => student.id != null)
              .map((student) => student.id!),
        );
    }

    notifyListeners();
  }

  Future<void> deleteSelectedStudents() async {
    final ids = List<int>.from(_selectedStudents);

    for (final id in ids) {
      await _repository.deleteStudent(id);
    }

    _selectedStudents.clear();

    await loadStudents();
  }

  void searchStudents(String value) {
    searchText = value;
    _refreshFilteredStudents();
    notifyListeners();
  }

  void filterByCourse(String? value) {
    selectedCourse = value ?? "All";
    _refreshFilteredStudents();
    notifyListeners();
  }

  void filterByYear(int? value) {
    selectedYear = value;
    _refreshFilteredStudents();
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < totalPages) {
      _currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      notifyListeners();
    }
  }

  void goToPage(int page) {
    if (page < 1 || page > totalPages) return;

    _currentPage = page;

    notifyListeners();
  }

  void _refreshFilteredStudents() {
    _filteredStudents =
        _students.where((student) {
          final matchesSearch =
              searchText.isEmpty ||
              student.studentNumber.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ||
              student.firstName.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ||
              student.middleName.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ||
              student.lastName.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ||
              student.fullName.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ||
              student.email.toLowerCase().contains(searchText.toLowerCase()) ||
              student.contactNumber.contains(searchText);

          final matchesCourse =
              selectedCourse == "All" || student.course == selectedCourse;

          final matchesYear =
              selectedYear == null || student.yearLevel == selectedYear;

          return matchesSearch && matchesCourse && matchesYear;
        }).toList();

    _currentPage = 1;
  }

  // void sort<T>(
  //   Comparable<T> Function(Student student) getField,
  //   int columnIndex,
  //   bool ascending,
  // ) {
  //   _filteredStudents.sort((a, b) {
  //     final aValue = getField(a);
  //     final bValue = getField(b);

  //     return ascending
  //         ? Comparable.compare(aValue, bValue)
  //         : Comparable.compare(bValue, aValue);
  //   });

  //   sortColumnIndex = columnIndex;
  //   sortAscending = ascending;

  //   notifyListeners();
  // }

  List<Student> get recentStudents {
    final students = List<Student>.from(_students);

    students.sort((a, b) {
      return (b.id ?? 0).compareTo(a.id ?? 0);
    });

    return students.take(5).toList();
  }

  int get totalBSCS => _students.where((s) => s.course == "BSCS").length;

  int get totalBSIT => _students.where((s) => s.course == "BSIT").length;

  int get totalBSIS => _students.where((s) => s.course == "BSIS").length;

  int get totalBSEMC => _students.where((s) => s.course == "BSEMC").length;
}
