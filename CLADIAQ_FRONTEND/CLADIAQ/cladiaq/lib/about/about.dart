import 'package:flutter/material.dart';

class AboutCq extends StatelessWidget {
  const AboutCq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text("ABOUT US"),
      ),
      body: Center(
        child: Text("About Us"),
      ),
    );
  }
}
