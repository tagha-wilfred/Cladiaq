import 'package:flutter/material.dart';

double calculateSubIndex(double concentration, double cLow, double cHigh,
    double iLow, double iHigh) {
  return ((iHigh - iLow) / (cHigh - cLow)) * (concentration - cLow) + iLow;
}

int calculateAQI(
    {required double temperature,
    required double pressure,
    required double sound,
    required double humidity,
    required double co2, // in ppm
    required double nh3, // in ppb
    required double co, // in ppm
    required double cov, // in µg/m³
    required double o3, // in ppb
    required double c5h5 // in µg/m³
    }) {
  // Define pollutant breakpoints (for simplicity, these are example breakpoints)
  // You can refine these based on actual environmental standards.

  // CO breakpoints (ppm)
  if (co > 12.4) co = 12.4; // Limit to max range for CO
  double coSubIndex =
      calculateSubIndex(co, 4.5, 9.4, 51, 100); // Example breakpoint

  // O3 breakpoints (ppb)
  if (o3 > 150) o3 = 150; // Limit to max range for O3
  double o3SubIndex = calculateSubIndex(o3, 101, 150, 51, 100);

  // NH3 breakpoints (ppb)
  if (nh3 > 300) nh3 = 300; // Limit to max range for NH3
  double nh3SubIndex = calculateSubIndex(nh3, 0, 200, 0, 100);

  // CO2 breakpoints (ppm)
  if (co2 > 1000) co2 = 1000; // Limit to max range for CO2
  double co2SubIndex = calculateSubIndex(co2, 400, 1000, 0, 100);

  // COV breakpoints (µg/m³)
  if (cov > 500) cov = 500; // Limit to max range for COV
  double covSubIndex = calculateSubIndex(cov, 0, 400, 0, 100);

  // C5H5 breakpoints (µg/m³)
  if (c5h5 > 100) c5h5 = 100; // Limit to max range for C5H5
  double c5h5SubIndex = calculateSubIndex(c5h5, 0, 80, 0, 100);

  // Here you can add more environmental factors (like temperature, humidity, etc.)
  // Example: temperature impact (using a comfort scale)
  if (temperature > 50) temperature = 50; // Limit extreme values
  double temperatureSubIndex = calculateSubIndex(temperature, 15, 30, 0, 100);

  // Combine the sub-indices to get the final AQI. You can choose to take the max
  // value or a weighted average of these pollutants.
  List<double> subIndices = [
    coSubIndex,
    o3SubIndex,
    nh3SubIndex,
    co2SubIndex,
    covSubIndex,
    c5h5SubIndex,
    temperatureSubIndex,
  ];

  // Return the maximum sub-index as the AQI (you can modify this to a weighted sum if needed)
  double maxAQI =
      subIndices.reduce((value, element) => value > element ? value : element);

  return maxAQI.round(); // Return the AQI as an integer
}

// Function to get both AQI color and comment
Map<String, dynamic> getAQIInfo(int aqi) {
  String comment;
  Color color;

  if (aqi >= 0 && aqi <= 50) {
    comment = "Good";
    color = Color(0xff009966); // Good
  } else if (aqi >= 51 && aqi <= 100) {
    comment = "Moderate";
    color = Color(0xffFFDE33); // Moderate
  } else if (aqi >= 101 && aqi <= 150) {
    comment = "Unhealthy for Sensitive Groups";
    color = Color(0xffFF9933); // Unhealthy for Sensitive Groups
  } else if (aqi >= 151 && aqi <= 200) {
    comment = "Unhealthy";
    color = Color(0xffCC0033); // Unhealthy
  } else if (aqi >= 201 && aqi <= 300) {
    comment = "Very Unhealthy";
    color = Color(0xff660099); // Very Unhealthy
  } else if (aqi >= 301 && aqi <= 500) {
    comment = "Hazardous";
    color = Color(0xff7E0023); // Hazardous (Maroon)
  } else {
    comment = "Invalid AQI";
    color = Colors.grey; // Invalid AQI or out of range
  }

  return {
    'comment': comment,
    'color': color,
  };
}

void main() {
  int aqiValue = 175; // Example AQI value
  Map<String, dynamic> aqiInfo = getAQIInfo(aqiValue);

  // Example of how to use color and comment
  Color aqiColor = aqiInfo['color'];
  String aqiComment = aqiInfo['comment'];

  // This is how you can use both in a Flutter app
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('AQI Status')),
      body: Center(
        child: Text(
          aqiComment,
          style: TextStyle(
              color: aqiColor, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  ));
}
