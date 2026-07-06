import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/data/model/models.dart';
import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/home/aqui_calculate.dart';
import 'package:flutter/material.dart';

class AqiSumHome extends StatelessWidget {
  final AQIsum aqIsum;
  const AqiSumHome({super.key, required this.aqIsum});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(4),
      height: 124,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sumText("${aqIsum.temperature.round()} °C"),
              sumText("${aqIsum.sound} dB")
            ],
          ),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                color: Color(0xff81CEF9),
                borderRadius: BorderRadius.circular(16)),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  top: 20,
                  child: Text(
                    "AQI",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Text(
                    aqIsum.aqi.toString(),
                    style: TextStyle(
                        color: getAQIInfo(aqIsum.aqi)['color'],
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sumText("${aqIsum.humidity} %"),
              sumText("${aqIsum.pressure}hPa")
            ],
          ),
        ],
      ),
    );
  }
}

Widget sumText(String text) {
  return Text(text,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xffA6A6A6)));
}
