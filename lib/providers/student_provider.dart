import 'package:flutter/material.dart';

import '../database/student_repository.dart';
import '../models/student.dart';

class StudentProvider extends ChangeNotifier {
  final StudentRepository _repository = StudentRepository();

  final List<Student> _students = [];

  List<Student> _filteredStudents = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Student> get students => List.unmodifiable(_students);

  List<Student> get filteredStudents => List.unmodifiable(_filteredStudents);

  // Search & Filter
  String searchText = "";
  String selectedCourse = "All";
  int? selectedYear;

  // Pagination
  int _currentPage = 1;
  final int _rowsPerPage = 10;

  int get currentPage => _currentPage;

  int get rowsPerPage => _rowsPerPage;

  int get totalStudents => _students.length;

  int get totalPages {
    if (_filteredStudents.isEmpty) return 1;

    return (_filteredStudents.length / _rowsPerPage).ceil();
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

  int get totalBSCS => _students.where((s) => s.course == "BSCS").length;

  int get totalBSIT => _students.where((s) => s.course == "BSIT").length;

  int get totalBSIS => _students.where((s) => s.course == "BSIS").length;

  int get totalBSEMC => _students.where((s) => s.course == "BSEMC").length;
}
