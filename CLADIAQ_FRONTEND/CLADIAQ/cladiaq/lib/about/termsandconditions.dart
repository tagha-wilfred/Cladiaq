import 'package:flutter/material.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text("Terms and Conditions"),
      ),
      body: Center(
        child: Text("Terms and Conditions"),
      ),
    );
  }
}
