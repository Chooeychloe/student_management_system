import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../database/database_helper.dart';

class BackupService {
  Future<bool> exportDatabase() async {
    try {
      final db = await DatabaseHelper.instance.database;

      final dbPath = db.path;

      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: "Export Database",
        fileName: "student_management_backup.db",
      );

      if (savePath == null) return false;

      await File(dbPath).copy(savePath);

      return true;
    } catch (e) {
      return false;
    }
  }
}
