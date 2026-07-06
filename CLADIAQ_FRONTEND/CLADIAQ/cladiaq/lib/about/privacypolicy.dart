import 'package:flutter/material.dart';

class PrivacyPoliy extends StatelessWidget {
  const PrivacyPoliy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text("PRIVACY POLICY"),
      ),
      body: Center(
        child: Text("Privacy Policy"),
      ),
    );
  }
}
