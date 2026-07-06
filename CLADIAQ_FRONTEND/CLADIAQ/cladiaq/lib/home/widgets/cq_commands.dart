import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/repository/user_repository.dart';
import 'package:cladiaq/signup/bloc/registration_bloc.dart';
import 'package:cladiaq/signup/bloc/registration_event.dart';
import 'package:cladiaq/signup/bloc/registration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class CqCommands extends StatelessWidget {
  const CqCommands({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Wrap(
        children: [
          CommandButton("ON", "assets/icons/gas.svg", name: "PURIFY"),
          CommandButton("ON", "assets/icons/humidity.svg", name: "HUMIDIFY"),
          CommandButton("CAPTURE", "assets/icons/cq_camera.svg"),
          CommandButton("STOP", "assets/icons/cq_stop.svg"),
        ],
      ),
    );
  }
}

Widget CommandButton(String command, String asset, {String? name}) {
  return BlocBuilder<RegistrationBloc, RegistrationState>(
    builder: (context, state) {
      return GestureDetector(
        onTap: () async {
          print("let us see how this work");
          BlocProvider.of<RegistrationBloc>(context).add(GetUser());
          print("done");
        },
        child: Container(
          margin: EdgeInsets.all(12),
          height: 80,
          width: 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: cqPrimaryColor, width: 4),
              color: Color(0xffF0F9FF)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                asset,
                color: cqPrimaryColor,
              ),
              SizedBox(
                child: (name != null)
                    ? Text(
                        name,
                        style: TextStyle(color: cqPrimaryColor, fontSize: 9),
                      )
                    : null,
              ),
              Text(
                command,
                style: TextStyle(
                    color: cqPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    },
  );
}
