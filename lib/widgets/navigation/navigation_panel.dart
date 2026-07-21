import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/navigation_provider.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = context.watch<NavigationProvider>();

    return Container(
      color: Colors.indigo,
      child: Column(
        children: [
          const SizedBox(height: 40),

          const Icon(Icons.school, color: Colors.white, size: 70),

          const SizedBox(height: 10),

          const Text(
            "Student\nManagement",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          _menuTile(
            context,
            page: AppPage.dashboard,
            icon: Icons.dashboard,
            title: "Dashboard",
          ),

          _menuTile(
            context,
            page: AppPage.settings,
            icon: Icons.settings,
            title: "Settings",
          ),
          _menuTile(
            context,
            page: AppPage.about,
            icon: Icons.info_outline,
            title: "About",
          ),

          _menuTile(
            context,
            page: AppPage.backupRestore,
            icon: Icons.backup,
            title: "Backup",
          ),
        ],
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required AppPage page,
    required IconData icon,
    required String title,
  }) {
    final navigation = context.watch<NavigationProvider>();

    final selected = navigation.currentPage == page;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Material(
        color: selected ? Colors.white.withOpacity(.18) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: () {
            navigation.navigateTo(page);
          },
        ),
      ),
    );
  }
}
