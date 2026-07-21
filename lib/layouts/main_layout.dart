import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/screens/students_screen.dart';

import '../core/constants.dart';
import '../providers/navigation_provider.dart';

import '../screens/about_screen.dart';
import '../screens/backup_restore_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/settings_screen.dart';

import '../widgets/navigation/navigation_panel.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SizedBox(
            width: AppConstants.sidebarWidth,
            child: NavigationPanel(),
          ),

          Expanded(
            child: Consumer<NavigationProvider>(
              builder: (context, navigation, child) {
                switch (navigation.currentPage) {
                  case AppPage.dashboard:
                    return const DashboardScreen();

                  case AppPage.students:
                    return const StudentsScreen();

                  case AppPage.backupRestore:
                    return const BackupRestoreScreen();

                  case AppPage.settings:
                    return const SettingsScreen();

                  case AppPage.about:
                    return const AboutScreen();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
