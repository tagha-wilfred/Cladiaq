import 'dart:convert'; // Import for JSON decoding
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class SensorDataPage extends StatefulWidget {
  @override
  _SensorDataPageState createState() => _SensorDataPageState();
}

class _SensorDataPageState extends State<SensorDataPage> {
  final WebSocketChannel channel =
      // IOWebSocketChannel.connect('ws://13.61.33.10:8000/ws/sensor-data/');
      // IOWebSocketChannel.connect('ws://10.0.2.2:8000/ws/sensor-data/');
      IOWebSocketChannel.connect('ws://13.60.4.19:8000/ws/sensor-data/');

  String temperature = "...";
  String pressure = "...";
  String humidity = "...";
  String sound = "...";

  @override
  void initState() {
    super.initState();
    channel.stream.listen((data) {
      final jsonData = json.decode(data);
      print(jsonData);

      setState(() {
        if (jsonData['sensor_data']['temperature']?.toString() != "2") {
          temperature =
              jsonData['sensor_data']['temperature']?.toString() ?? "...";
        }
        pressure = jsonData['sensor_data']['atm_pressure']?.toString() ?? "...";
        humidity = jsonData['sensor_data']['humidity']?.toString() ?? "...";
        sound = jsonData['sensor_data']['sound']?.toString() ?? "...";
      });
    }, onDone: () {
      debugPrint("WebSocket was closed");
    }, onError: (error) {
      debugPrint(error.toString());
    });
  }

  @override
  void dispose() {
    channel.sink.close(); // Close the WebSocket connection
    super.dispose();
  }

  Map<String, dynamic> getSensorInfo(String type, double value) {
    String comment;
    Color color;

    switch (type) {
      case 'temperature':
        if (value < 0) {
          comment = "Freezing";
          color = Color(0xff009966); // Good
        } else if (value < 20) {
          comment = "Cool";
          color = Color(0xffFFDE33); // Moderate
        } else if (value < 30) {
          comment = "Warm";
          color = Color(0xffFF9933); // Unhealthy for Sensitive Groups
        } else {
          comment = "Hot";
          color = Color(0xffCC0033); // Unhealthy
        }
        break;

      case 'pressure':
        if (value < 950) {
          comment = "Low Pressure";
          color = Color(0xff660099); // Very Unhealthy
        } else if (value < 1010) {
          comment = "Normal Pressure";
          color = Color(0xff009966); // Good
        } else {
          comment = "High Pressure";
          color = Color(0xffCC0033); // Unhealthy
        }
        break;

      case 'humidity':
        if (value < 30) {
          comment = "Low Humidity";
          color = Color(0xff009966); // Good
        } else if (value < 60) {
          comment = "Comfortable";
          color = Color(0xffFFDE33); // Moderate
        } else {
          comment = "High Humidity";
          color = Color(0xffFF9933); // Unhealthy for Sensitive Groups
        }
        break;

      case 'sound':
        if (value < 30) {
          comment = "Quiet";
          color = Color(0xff009966); // Good
        } else if (value < 70) {
          comment = "Moderate Noise";
          color = Color(0xffFFDE33); // Moderate
        } else {
          comment = "Loud Noise";
          color = Color(0xffCC0033); // Unhealthy
        }
        break;

      default:
        comment = "Invalid";
        color = Colors.grey; // Default for invalid cases
    }

    return {
      'comment': comment,
      'color': color,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F4FA),
      appBar: AppBar(
        title: Text('Live Atmosphere Data'),
        centerTitle: true,
      ),
      // body: Center(
      //   child: SizedBox(
      //     height: 500,
      //     child: Column(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.all(4.0),
      //           child: Expanded(
      //             child: GridView.count(
      //               crossAxisCount: 2, // 2 columns
      //               crossAxisSpacing: 16.0,
      //               mainAxisSpacing: 16.0,
      //               children: [
      //                 _buildSensorWidget(
      //                     "Temperature", temperature, Icons.thermostat),
      //                 _buildSensorWidget("Pressure", pressure, Icons.cloud),
      //                 _buildSensorWidget("Humidity", humidity, Icons.opacity),
      //                 _buildSensorWidget("Sound", sound, Icons.volume_up),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Center(
        child: SizedBox(
          height: 500,
          child: GridView.count(
            crossAxisCount: 2, // Two columns
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            padding: EdgeInsets.all(16.0),
            children: [
              _buildSensorWidget("Temperature", temperature, Icons.thermostat),
              _buildSensorWidget("Pressure", pressure, Icons.cloud),
              _buildSensorWidget("Humidity", humidity, Icons.opacity),
              _buildSensorWidget("Sound", sound, Icons.volume_up),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSensorWidget(String title, String value, IconData icon) {
    double parsedValue = double.tryParse(value) ?? -1;

    final sensorInfo = getSensorInfo(title.toLowerCase(), parsedValue);
    Color bgColor = sensorInfo['color'];
    String comment = sensorInfo['comment'];

    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 10),
              Text(value, style: TextStyle(fontSize: 24, color: Colors.white)),
              SizedBox(height: 10),
              Text(comment,
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
