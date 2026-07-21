import 'package:flutter/material.dart';

import '../database/student_repository.dart';
import '../models/student.dart';

class RecentStudentsProvider extends ChangeNotifier {
  final StudentRepository _repository = StudentRepository();

  List<Student> _recentStudents = [];

  List<Student> get recentStudents => _recentStudents;

  Future<void> loadRecentStudents() async {
    final students = await _repository.getStudents();

    students.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));

    _recentStudents = students.take(5).toList();

    notifyListeners();
  }

  Future<void> refresh() async {
    await loadRecentStudents();
  }
}
