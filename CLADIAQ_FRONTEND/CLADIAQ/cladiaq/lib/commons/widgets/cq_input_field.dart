import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/commons/widgets/cq_button.dart';
import 'package:cladiaq/commons/widgets/cq_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CqInputField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final bool otp;

  const CqInputField(
      {Key? key,
      required this.controller,
      this.placeholder = '',
      this.password = false,
      this.leading,
      this.trailing,
      this.otp = false})
      : super(key: key);

  @override
  State<CqInputField> createState() => _CqInputFieldState();
}

class _CqInputFieldState extends State<CqInputField> {
  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.password; // Initialize here
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.otp
        ? OtpTextField(
            fieldHeight: 65,
            fieldWidth: 62,
            numberOfFields: 4,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            borderColor: Colors.black,
            focusedBorderColor: cqMediumGreyColor,
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                        child: Container(
                      padding: EdgeInsets.all(16),
                      height: screenHeight(context) * 0.26,
                      width: screenWidth(context) * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                CqText.heading3("Logout"),
                                verticalSpaceSmall,
                                CqText.body(
                                    "Are you sure you want to log out? You'll need to login again to use the app."),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 130,
                                height: 40,
                                child: CqButton(
                                    title: "Cancel",
                                    outline: true,
                                    outlineblue: true,
                                    onPressedCq: () {}),
                              ),
                              horizontalSpaceSmall,
                              SizedBox(
                                width: 130,
                                height: 40,
                                child: CqButton(
                                    title: "Logout", onPressedCq: () {}),
                              )
                            ],
                          )
                        ],
                      ),
                    ));
                  });
            }, // end onSubmit
          )
        : TextField(
            controller: widget.controller,
            style: const TextStyle(height: 1.5),
            obscureText: _isObscured, // Use the state variable here
            decoration: InputDecoration(
              hintText: widget.placeholder,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              filled: true,
              prefixIcon: widget.leading,
              suffixIcon: widget.password // Show toggle only for password field
                  ? GestureDetector(
                      onTap: _togglePasswordVisibility,
                      child: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                  : widget.trailing,
              fillColor: Colors.white,
              border: circularBorder.copyWith(
                  borderSide: const BorderSide(color: cqLightGreyColor)),
              errorBorder: circularBorder.copyWith(
                  borderSide: const BorderSide(color: cqDanger)),
              focusedBorder: circularBorder.copyWith(
                  borderSide: const BorderSide(color: cqMediumGreyColor)),
              enabledBorder: circularBorder.copyWith(
                  borderSide: const BorderSide(color: cqLightGreyColor)),
            ),
          );
  }
}
