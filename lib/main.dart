import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:student_management_system/providers/navigation_provider.dart';
import 'package:student_management_system/providers/recent_students_provider.dart';

import 'core/app_theme.dart';
import 'database/database_helper.dart';
import 'providers/student_provider.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SQLite for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Initialize database
  await DatabaseHelper.instance.database;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudentProvider()..loadStudents(),
        ),

        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => RecentStudentsProvider()..loadRecentStudents(),
        ),
      ],

      child: const StudentManagementApp(),
    ),
  );
}

class StudentManagementApp extends StatelessWidget {
  const StudentManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management System',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
