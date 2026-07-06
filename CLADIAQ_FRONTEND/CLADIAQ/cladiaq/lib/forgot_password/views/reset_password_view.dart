import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/home/views/home_page.dart';
import 'package:cladiaq/commons/widgets/cq_button.dart';
import 'package:cladiaq/commons/widgets/cq_input_field.dart';
import 'package:cladiaq/commons/widgets/cq_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordPassword extends StatelessWidget {
  const ForgotPasswordPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CqText.heading3('Create password'),
                  verticalSpaceRegular,
                  CqText.body('Create your new password to login'),
                  verticalSpaceRegular,
                  CqInputField(
                    leading: Image.asset('assets/icons/lock.png'),
                    trailing: Image.asset('assets/icons/password.png'),
                    controller: TextEditingController(),
                    placeholder: "Password",
                    password: true,
                  ),
                  verticalSpaceMedium,
                  CqInputField(
                    leading: Image.asset('assets/icons/lock.png'),
                    trailing: Image.asset('assets/icons/password.png'),
                    controller: TextEditingController(),
                    placeholder: "Confirm Password",
                    password: true,
                  ),
                  verticalSpaceRegular,
                  CqButton(
                      title: 'Reset My Password',
                      onPressedCq: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      })
                ],
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    "assets/icons/cq_back.svg",
                    color: Colors.blue,
                    height: 50,
                    width: 50,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
