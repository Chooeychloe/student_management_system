import 'package:flutter/material.dart';

import '../database/student_repository.dart';
import '../models/student.dart';

class StudentProvider extends ChangeNotifier {
  final StudentRepository _repository = StudentRepository();

  List<Student> _students = [];
  List<Student> filteredStudents = [];
  List<Student> get students => _students;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int _currentPage = 1;
  final int _rowsPerPage = 10;

  int get currentPage => _currentPage;
  int get rowsPerPage => _rowsPerPage;

  String searchText = "";

  String selectedCourse = "All";

  int? selectedYear;

  List<Student> get paginatedStudents {
    final start = (_currentPage - 1) * _rowsPerPage;
    final end = start + _rowsPerPage;

    if (start >= _students.length) return [];

    return _students.sublist(
      start,
      end > _students.length ? _students.length : end,
    );
  }

  int get totalPages => (_students.length / _rowsPerPage).ceil();

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
    if (page >= 1 && page <= totalPages) {
      _currentPage = page;
      notifyListeners();
    }
  }

  Future<void> loadStudents() async {
    _isLoading = true;
    notifyListeners();

    _students = await _repository.getStudents();

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

  int get totalStudents => _students.length;
  void applyFilters() {
    filteredStudents =
        students.where((student) {
          final matchesSearch =
              student.fullName.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ||
              student.studentNumber.contains(searchText);

          final matchesCourse =
              selectedCourse == "All" || student.course == selectedCourse;

          final matchesYear =
              selectedYear == null || student.yearLevel == selectedYear;

          return matchesSearch && matchesCourse && matchesYear;
        }).toList();

    notifyListeners();
  }

  void searchStudents(String value) {
    searchText = value;

    applyFilters();
  }

  void filterByCourse(String? value) {
    selectedCourse = value ?? "All";

    applyFilters();
  }

  void filterByYear(int? value) {
    selectedYear = value;

    applyFilters();
  }

  int get totalBSCS => students.where((s) => s.course == "BSCS").length;

  int get totalBSIT => students.where((s) => s.course == "BSIT").length;

  int get totalBSIS => students.where((s) => s.course == "BSIS").length;

  int get totalBSEMC => students.where((s) => s.course == "BSEMC").length;
}
