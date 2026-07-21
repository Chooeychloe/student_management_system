import 'dart:async';

import 'package:flutter/material.dart';
import 'package:student_management_system/layouts/main_layout.dart';

import '../core/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainLayout()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.school_rounded, size: 100, color: Colors.white),

            SizedBox(height: 25),

            Text(
              AppConstants.appName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Flutter Desktop Edition",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),

            SizedBox(height: 50),

            SizedBox(width: 250, child: LinearProgressIndicator()),

            SizedBox(height: 20),

            Text(
              "Loading...",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),

            SizedBox(height: 60),

            Text("Version 1.0", style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
