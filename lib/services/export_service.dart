import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

import '../models/student.dart';

class ExportService {
  Future<bool> exportStudentsToCSV(List<Student> students) async {
    try {
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: "Export Student List",
        fileName: "students.csv",
      );

      if (savePath == null) {
        return false;
      }

      final List<List<dynamic>> rows = [];

      rows.add([
        "Student Number",
        "First Name",
        "Middle Name",
        "Last Name",
        "Course",
        "Year Level",
        "Email",
        "Contact Number",
        "Address",
      ]);

      for (final student in students) {
        rows.add([
          student.studentNumber,
          student.firstName,
          student.middleName,
          student.lastName,
          student.course,
          student.yearLevel,
          student.email,
          student.contactNumber,
          student.address,
        ]);
      }

      final csv = const ListToCsvConverter().convert(rows);

      final file = File(savePath);

      await file.writeAsString(csv);

      return true;
    } catch (e) {
      return false;
    }
  }
}
