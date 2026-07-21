import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

import '../database/student_repository.dart';
import '../models/import_result.dart';
import '../models/student.dart';

class ImportService {
  final StudentRepository _repository = StudentRepository();

  static const List<String> _expectedHeader = [
    "Student Number",
    "First Name",
    "Middle Name",
    "Last Name",
    "Course",
    "Year Level",
    "Email",
    "Contact Number",
    "Address",
  ];

  static const List<String> _allowedCourses = ["BSCS", "BSIT", "BSIS", "BSEMC"];

  Future<ImportResult> importStudentsFromCSV() async {
    final result = ImportResult();

    try {
      final fileResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (fileResult == null) {
        return result;
      }

      final file = File(fileResult.files.single.path!);

      final csvString = await file.readAsString();

      final rows = const CsvToListConverter(eol: '\n').convert(csvString);

      if (rows.isEmpty) {
        result.addError("CSV file is empty.");
        return result;
      }

      //-------------------------------
      // Validate Header
      //-------------------------------

      final header = rows.first;

      if (header.length != _expectedHeader.length) {
        result.addError("Invalid CSV format.");
        return result;
      }

      for (int i = 0; i < _expectedHeader.length; i++) {
        if (header[i].toString().trim() != _expectedHeader[i]) {
          result.addError(
            "Invalid CSV header. Expected '${_expectedHeader[i]}'.",
          );
          return result;
        }
      }

      //-------------------------------
      // Existing Students
      //-------------------------------

      final existingStudents = await _repository.getStudents();

      final existingNumbers =
          existingStudents.map((e) => e.studentNumber.trim()).toSet();

      final importedNumbers = <String>{};

      //-------------------------------
      // Import Rows
      //-------------------------------

      for (int i = 1; i < rows.length; i++) {
        final row = rows[i];

        if (row.length < 9) {
          result.invalid++;
          result.addError("Row ${i + 1}: Missing columns.");
          continue;
        }

        final studentNumber = row[0].toString().trim();
        final firstName = row[1].toString().trim();
        final middleName = row[2].toString().trim();
        final lastName = row[3].toString().trim();
        final course = row[4].toString().trim();
        final yearText = row[5].toString().trim();
        final email = row[6].toString().trim();
        String contact = row[7].toString().trim();

        // Excel/CSV sometimes removes the leading zero
        if (contact.length == 10 && contact.startsWith('9')) {
          contact = '0$contact';
        }

        // Remove trailing .0 if present
        if (contact.endsWith('.0')) {
          contact = contact.substring(0, contact.length - 2);
        }
        final address = row[8].toString().trim();

        //-------------------------------
        // Required Fields
        //-------------------------------

        if (studentNumber.isEmpty || firstName.isEmpty || lastName.isEmpty) {
          result.invalid++;
          result.addError("Row ${i + 1}: Required fields are missing.");
          continue;
        }

        //-------------------------------
        // Course Validation
        //-------------------------------

        if (!_allowedCourses.contains(course)) {
          result.invalid++;
          result.addError("Row ${i + 1}: Invalid course '$course'.");
          continue;
        }

        //-------------------------------
        // Year Validation
        //-------------------------------

        final yearLevel = int.tryParse(yearText);

        if (yearLevel == null || yearLevel < 1 || yearLevel > 4) {
          result.invalid++;
          result.addError("Row ${i + 1}: Invalid year level.");
          continue;
        }

        //-------------------------------
        // Email Validation
        //-------------------------------

        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

        if (email.isNotEmpty && !emailRegex.hasMatch(email)) {
          result.invalid++;
          result.addError("Row ${i + 1}: Invalid email address.");
          continue;
        }

        //-------------------------------
        // Contact Validation
        //-------------------------------

        final phoneRegex = RegExp(r'^09\d{9}$');

        if (contact.isNotEmpty && !phoneRegex.hasMatch(contact)) {
          result.invalid++;
          result.addError("Row ${i + 1}: Invalid contact number.");
          continue;
        }

        //-------------------------------
        // Duplicate Validation
        //-------------------------------

        if (existingNumbers.contains(studentNumber) ||
            importedNumbers.contains(studentNumber)) {
          result.duplicates++;
          result.addError(
            "Row ${i + 1}: Student Number '$studentNumber' already exists.",
          );
          continue;
        }

        //-------------------------------
        // Save Student
        //-------------------------------

        final student = Student(
          studentNumber: studentNumber,
          firstName: firstName,
          middleName: middleName,
          lastName: lastName,
          course: course,
          yearLevel: yearLevel,
          email: email,
          contactNumber: contact,
          address: address,
        );

        await _repository.addStudent(student);

        existingNumbers.add(studentNumber);
        importedNumbers.add(studentNumber);

        result.imported++;
      }

      return result;
    } catch (e) {
      result.addError("Unexpected error: $e");
      return result;
    }
  }
}
