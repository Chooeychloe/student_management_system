import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../database/database_helper.dart';

class RestoreService {
  Future<bool> restoreDatabase() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
      );

      if (result == null) return false;

      final selectedFile = result.files.single.path!;

      final db = await DatabaseHelper.instance.database;

      final dbPath = db.path;

      await db.close();

      await File(selectedFile).copy(dbPath);

      return true;
    } catch (e) {
      return false;
    }
  }
}
