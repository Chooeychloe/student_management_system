import '../models/student.dart';
import 'database_helper.dart';

class StudentRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Student>> getStudents() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query('students', orderBy: 'lastName ASC');

    return result.map((e) => Student.fromMap(e)).toList();
  }

  Future<int> addStudent(Student student) async {
    final db = await dbHelper.database;

    return await db.insert('students', student.toMap());
  }

  Future<int> updateStudent(Student student) async {
    final db = await DatabaseHelper.instance.database;

    return await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete('students', where: 'id=?', whereArgs: [id]);
  }

  Future<int> insertStudent(Student student) async {
    final db = await DatabaseHelper.instance.database;

    return await db.insert('students', student.toMap());
  }
}
