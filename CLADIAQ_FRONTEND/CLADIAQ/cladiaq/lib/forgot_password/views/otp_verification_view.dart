import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/forgot_password/views/reset_password_view.dart';
import 'package:cladiaq/commons/widgets/cq_button.dart';
import 'package:cladiaq/commons/widgets/cq_input_field.dart';
import 'package:cladiaq/commons/widgets/cq_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordOtp extends StatelessWidget {
  const ForgotPasswordOtp({super.key});

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
                  const CqText.heading3('Enter Verification Code'),
                  verticalSpaceRegular,
                  CqText.body(
                      'Enter the verification code that has been sent to your email testemail@gmail.com'),
                  verticalSpaceRegular,
                  CqInputField(
                    controller: TextEditingController(),
                    otp: true,
                  ),
                  verticalSpaceRegular,
                  CqButton(
                      title: 'Verify',
                      onPressedCq: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPassword()));
                      }),
                  verticalSpaceRegular,
                  Center(
                    child: GestureDetector(
                        child: CqText.body(
                      'Resend',
                      color: cqPrimaryColor,
                    )),
                  )
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
