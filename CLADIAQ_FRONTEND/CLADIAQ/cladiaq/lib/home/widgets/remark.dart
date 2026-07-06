import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/home/aqui_calculate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AQIRemark extends StatelessWidget {
  final int aqi;
  const AQIRemark({super.key, required this.aqi});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 70,
      child: Column(
        children: [
          Text(
            getAQIInfo(aqi)['comment'],
            style: TextStyle(color: getAQIInfo(aqi)['color'], fontSize: 20),
          ),
          Container(
            width: 300,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 300, // Adjust width to your need
                    height: 15, // Adjust height to your need
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xff009966),
                          Color(0xffFFDE33),
                          Color(0xffFF9933),
                          Color(0xffCC0033),
                          Color(0xff660099),
                          Color(0xff7E0023),
                        ],
                        stops: [
                          0.0, // Red at 0%
                          0.2, // Orange at 20%
                          0.4, // Yellow at 40%
                          0.6, // Green at 60%
                          0.8, // Blue at 80%
                          1.0, // Purple at 100%
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: aqi < 600 ? aqi / 600 * 300 : 0,
                    child: SvgPicture.asset(
                      'assets/icons/cq_stroke.svg',
                      color: Color(0xffA6A6A6),
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "100",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "200",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "300",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "400",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "500",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "600",
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
