import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/forgot_password/views/otp_verification_view.dart';
import 'package:cladiaq/commons/widgets/cq_button.dart';
import 'package:cladiaq/commons/widgets/cq_input_field.dart';
import 'package:cladiaq/commons/widgets/cq_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordEmail extends StatelessWidget {
  const ForgotPasswordEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CqText.heading3('Forgot Your Password'),
                  verticalSpaceRegular,
                  CqText.body(
                      'No worries, you just need to type your email address or username and we will send the verification code.'),
                  verticalSpaceRegular,
                  CqInputField(
                    controller: TextEditingController(),
                    leading: Image.asset('assets/icons/email.png'),
                    placeholder: "Enter your Email",
                  ),
                  verticalSpaceRegular,
                  CqButton(
                      title: 'Reset My Password',
                      onPressedCq: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordOtp()));
                      })
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 15,
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
