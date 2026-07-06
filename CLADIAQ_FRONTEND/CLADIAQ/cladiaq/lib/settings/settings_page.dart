import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/commons/widgets/buttom_navigation/cq_buttomn_nav_bar.dart';
import 'package:cladiaq/commons/widgets/cq_app_bar.dart';
import 'package:cladiaq/commons/widgets/cq_profile_img.dart';
import 'package:cladiaq/settings/settings_view.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Settings"),
            verticalSpaceSmall,
            const CqProfileImg(),
            SizedBox(
                height: screenHeight(context) * 0.7,
                child: const SettingsView())
          ],
        ),
      ),
      bottomNavigationBar: const CqButtomnNavBar(
        page: 4,
      ),
    );
  }
}
