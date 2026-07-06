// screens/signup.dart
import 'package:cladiaq/commons/data/services/authentication_service.dart';
import 'package:cladiaq/commons/repository/user_repository.dart';
import 'package:cladiaq/signup/bloc/registration_bloc.dart';
import 'package:cladiaq/signup/bloc/registration_event.dart';
import 'package:cladiaq/signup/bloc/registration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/login/login_view.dart';
import 'package:cladiaq/commons/widgets/cq_button.dart';
import 'package:cladiaq/commons/widgets/cq_input_field.dart';
import 'package:cladiaq/commons/widgets/cq_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool checkbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationSuccess) {
                Navigator.pushReplacementNamed(context, '/login');
                // Navigate to the home screen or show success message
              } else if (state is RegistrationFailure) {
                // Show error message
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpaceLarge,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    children: [
                      CqText.headline("Sign Up"),
                    ],
                  ),
                ),
                verticalSpaceSmall,
                Center(
                  child: SizedBox(
                    width: screenWidth(context) * 0.9,
                    child: CqInputField(
                      controller: fullNameController,
                      leading: const Icon(Icons.person),
                      // SvgPicture.asset(
                      //   "assets/icons/cq_person.svg",
                      //   height: 6,
                      //   width: 6,
                      // ),
                      placeholder: "Full Name",
                    ),
                  ),
                ),
                verticalSpaceSmall,
                Center(
                  child: SizedBox(
                    width: screenWidth(context) * 0.9,
                    child: CqInputField(
                      controller: emailController,
                      leading: Image.asset("assets/icons/email.png"),
                      placeholder: "Enter your Email",
                    ),
                  ),
                ),
                verticalSpaceSmall,
                Center(
                  child: SizedBox(
                    width: screenWidth(context) * 0.9,
                    child: CqInputField(
                      controller: mobileController,
                      leading: Image.asset("assets/icons/phone.png"),
                      placeholder: "Mobile",
                    ),
                  ),
                ),
                verticalSpaceSmall,
                Center(
                  child: SizedBox(
                    width: screenWidth(context) * 0.9,
                    child: CqInputField(
                      password: true,
                      controller: passwordController,
                      leading: Image.asset("assets/icons/lock.png"),
                      placeholder: "Password",
                      trailing: Image.asset("assets/icons/password.png"),
                    ),
                  ),
                ),
                verticalSpaceSmall,
                Center(
                  child: SizedBox(
                    width: screenWidth(context) * 0.9,
                    child: CqInputField(
                      password: true,
                      controller: confirmPasswordController,
                      leading: Image.asset("assets/icons/lock.png"),
                      placeholder: "Confirm Password",
                      trailing: Image.asset("assets/icons/password.png"),
                    ),
                  ),
                ),
                verticalSpaceSmall,
                SizedBox(
                  width: screenWidth(context) * 0.85,
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: cqPrimaryColor,
                        value: checkbox,
                        onChanged: (t) {
                          setState(() {
                            checkbox = !checkbox;
                          });
                        },
                      ),
                      Container(
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("I agree to the",
                                    style: TextStyle(fontSize: 15)),
                                Text("Terms & Conditions",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: cqPrimaryColor,
                                        decoration: TextDecoration.underline)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("and"),
                                Text(" Privacy Policy",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: cqPrimaryColor,
                                        decoration: TextDecoration.underline)),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                verticalSpaceTiny,
                SizedBox(
                  width: screenWidth(context) * 0.4,
                  child: BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      return CqButton(
                        busy: (state is RegistrationLoading),
                        title: "Sign up",
                        onPressedCq: () {
                          final fullName = fullNameController.text;
                          final email = emailController.text;
                          final mobile = mobileController.text;
                          final password = passwordController.text;

                          if (checkbox) {
                            context.read<RegistrationBloc>().add(
                                  RegistrationButtonPressed(
                                    fullName: fullName,
                                    email: email,
                                    mobile: mobile,
                                    password: password,
                                  ),
                                );
                          } else {
                            // Show an error message if the checkbox is not checked
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Please agree to the terms and conditions")));
                          }
                        },
                      );
                    },
                  ),
                ),
                verticalSpaceSmall,
                const CqText.heading3("Or"),
                verticalSpaceSmall,
                SizedBox(
                  width: screenWidth(context) * 0.75,
                  child: CqButton(
                    leading: Image.asset('assets/icons/google.png'),
                    title: "Login With Google",
                    onPressedCq: () {},
                    outline: true,
                  ),
                ),
                verticalSpaceSmall,
                SizedBox(
                  width: screenWidth(context) * 0.75,
                  child: CqButton(
                    title: "Login With Facebook",
                    onPressedCq: () {},
                    outline: true,
                    leading: Image.asset('assets/icons/facebook.png'),
                  ),
                ),
                verticalSpaceTiny,
                SizedBox(
                  width: screenWidth(context) * 0.75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account"),
                      horizontalSpaceSmall,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogIn()));
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                              color: cqPrimaryColor,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
