import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'student_management.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        studentNumber TEXT NOT NULL,
        firstName TEXT NOT NULL,
        middleName TEXT,
        lastName TEXT NOT NULL,
        course TEXT NOT NULL,
        yearLevel INTEGER NOT NULL,
        email TEXT NOT NULL UNIQUE,
        contactNumber TEXT,
        address TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE students ADD COLUMN email TEXT");
      await db.execute("ALTER TABLE students ADD COLUMN contactNumber TEXT");
      await db.execute("ALTER TABLE students ADD COLUMN address TEXT");
      await db.execute("ALTER TABLE students ADD COLUMN middleName TEXT");
    }
  }
}
