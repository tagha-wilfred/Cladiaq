import 'dart:developer';

import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/data/services/authentication_service.dart';
import 'package:cladiaq/commons/repository/user_repository.dart';
import 'package:cladiaq/commons/widgets/buttom_navigation/bloc/buttom_navigation_bloc.dart';
import 'package:cladiaq/device_data/bloc/device_data_bloc.dart';
import 'package:cladiaq/device_data/device_data_view.dart';
import 'package:cladiaq/device_data/services/device_data_service.dart';
import 'package:cladiaq/home/bloc/home_bloc.dart';
import 'package:cladiaq/home/home_view.dart';
import 'package:cladiaq/home/repository.dart';
import 'package:cladiaq/chatbot/chatbot.dart';
import 'package:cladiaq/login/bloc/login_bloc.dart';
import 'package:cladiaq/login/login_view.dart';
import 'package:cladiaq/news/news.dart';
import 'package:cladiaq/onboarding/onboarding_view.dart';
import 'package:cladiaq/settings/settings_page.dart';
import 'package:cladiaq/signup/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? true;
  log(onboarding.toString());
  runApp(MyApp(
    onboarding: onboarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({Key? key, required this.onboarding}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();
    AuthenticationService authenticationService =
        AuthenticationService(userRepository);
    DeviceDataService deviceDataService = DeviceDataService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(authenticationService),
        ),
        BlocProvider(
          create: (context) => RegistrationBloc(authenticationService),
        ),
        BlocProvider(create: (context) => DeviceDataBloc(deviceDataService)),
        BlocProvider(
          create: (context) => HomeBloc(
            sensorDataRepository: SensorDataRepository(), // Pass the repository
          )..add(HomeStartEvent()), // Trigger the event to start fetching data
        ),
        BlocProvider(
            create: (context) =>
                ButtomNavigationBloc()..add(HomeButtonClicked()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: cqPrimaryColor,
              ),
        ),
        routes: {
          "/": (context) => onboarding ? const OnboardingView() : HomePage(),
          "/dashboard": (context) => const HomePage(),
          "/login": (context) => const LogIn(),
          "/news": (context) => NewsPage(),
          "/ai": (context) => AirQualityChatbotPage(),
          "/settings": (context) => const SettingsPage()
        },
      ),
    );
  }
}
