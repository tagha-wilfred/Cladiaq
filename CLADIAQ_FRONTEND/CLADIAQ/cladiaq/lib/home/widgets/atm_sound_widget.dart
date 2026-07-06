import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:flutter/material.dart';

class AtmSound extends StatelessWidget {
  final int humidity;
  final int pressure;
  const AtmSound({super.key, required this.humidity, required this.pressure});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AtmWidget("HUMIDITY", humidity.toString(),
              humidity >= 35 && humidity <= 65),
          AtmWidget("ATM PRESSURE", pressure.toString(),
              pressure >= 890 && humidity <= 1030),
        ],
      ),
    );
  }

  Widget AtmWidget(String title, String value, bool isGood) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            title,
            style:
                TextStyle(color: isGood ? cqPrimaryColor : Color(0xffFB8F42)),
          ),
          verticalSpaceSmall,
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(isGood
                    ? "assets/images/loader_blue.png"
                    : "assets/images/loader-red.png"),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 20,
                      color: isGood ? cqPrimaryColor : Color(0xffFB8F42)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
