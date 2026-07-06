import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/home/recomendation.dart';
import 'package:flutter/material.dart';

class CqRecommendationWidget extends StatelessWidget {
  final aqi;
  const CqRecommendationWidget({super.key, required this.aqi});

  @override
  Widget build(BuildContext context) {
    final reccomendation = getAQIRecommendations(aqi);
    return Container(
      padding: EdgeInsets.all(16),
      // margin: EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Color(0xff81CEF9)),

      height: 200,
      width: 338,
      child: Container(
        width: 256,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "NOTES",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            verticalSpaceTiny,
            Text(
              reccomendation.first,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff666666), fontSize: 14),
            ),
            verticalSpaceTiny,
            Text(
              reccomendation.last,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff666666), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
