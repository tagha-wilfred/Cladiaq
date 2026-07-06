// screens/login_view.dart
import 'package:cladiaq/commons/data/services/authentication_service.dart';
import 'package:cladiaq/commons/repository/user_repository.dart';
import 'package:cladiaq/forgot_password/create_new_password.dart';
import 'package:cladiaq/login/bloc/login_bloc.dart';
import 'package:cladiaq/login/bloc/login_event.dart';
import 'package:cladiaq/login/bloc/login_state.dart';
import 'package:cladiaq/signup/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Adjust path as necessary
import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/ui_helpers.dart';

import 'package:cladiaq/signup/signup_view.dart';
import 'package:cladiaq/commons/widgets/cq_button.dart';
import 'package:cladiaq/commons/widgets/cq_input_field.dart';
import 'package:cladiaq/commons/widgets/cq_text.dart';
import 'package:cladiaq/commons/widgets/cq_toogle_button.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool toggleValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacementNamed(context, '/dashboard');
              } else if (state is LoginFailure) {
                // Show error message

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
                Navigator.pushReplacementNamed(context, '/login');
              } else if (state is LoginLoading) {
                // Show error message
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Loading')));
              }
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    children: [
                      CqText.headline("Login"),
                    ],
                  ),
                ),
                verticalSpaceSmall,
                Image.asset('assets/images/ima2.png'),
                verticalSpaceSmall,
                SizedBox(
                  width: screenWidth(context) * 0.85,
                  child: CqInputField(
                    controller: emailController,
                    leading: Image.asset('assets/icons/email.png'),
                    placeholder: "Enter your Email",
                  ),
                ),
                verticalSpaceMedium,
                SizedBox(
                  width: screenWidth(context) * 0.85,
                  child: CqInputField(
                    leading: Image.asset('assets/icons/lock.png'),
                    trailing: Image.asset('assets/icons/password.png'),
                    controller: passwordController,
                    placeholder: "Password",
                    password: true,
                  ),
                ),
                verticalSpaceSmall,
                SizedBox(
                  height: 20,
                  width: screenWidth(context) * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CqToogleButton(
                            toggleFunct: () {
                              setState(() {
                                toggleValue = !toggleValue;
                              });
                            },
                            toggleValue: toggleValue,
                          ),
                          horizontalSpaceSmall,
                          const CqText.caption("Remember Me")
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgotPasswordEmail()));
                          },
                          child: const CqText.caption("Forgot Password?")),
                    ],
                  ),
                ),
                verticalSpaceSmall,
                SizedBox(
                  width: screenWidth(context) * 0.4,
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (contexte, state) {
                      return CqButton(
                        busy: (state is LoginLoading),
                        title: "Login",
                        onPressedCq: () {
                          final email = emailController.text;
                          final password = passwordController.text;

                          context.read<LoginBloc>().add(LoginButtonPressed(
                              email: email, password: password));
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
                    title: "Signup With Google",
                    onPressedCq: () {},
                    outline: true,
                  ),
                ),
                verticalSpaceSmall,
                SizedBox(
                  width: screenWidth(context) * 0.75,
                  child: CqButton(
                    title: "Signup With Facebook",
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
                      const Text("Don't have an Account?"),
                      horizontalSpaceSmall,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => RegistrationBloc(
                                          AuthenticationService(
                                              UserRepository())),
                                      child: const SignUp(),
                                    )),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: cqPrimaryColor,
                            decoration: TextDecoration.underline,
                          ),
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
