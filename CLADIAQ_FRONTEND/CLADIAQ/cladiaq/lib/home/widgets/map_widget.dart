// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class MapWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 3,
//       decoration: BoxDecoration(color: Colors.blue[100]),
//       child: FlutterMap(
//         options: MapOptions(
//           initialCenter: LatLng(12.2472, 7.3442),
//           initialZoom: 20,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//             subdomains: ['a', 'b', 'c'],
//           ),
//           MarkerLayer(
//             markers: [
//               Marker(
//                 point: LatLng(51.5, -0.09),
//                 child: Icon(Icons.location_on, color: Colors.red),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AQI Map Example',
      home: Scaffold(
        appBar: AppBar(title: Text('AQI Map')),
        body: Center(
          child: MapWidget(),
        ),
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.7,
      child: FlutterMap(
        options: MapOptions(
          initialCenter:
              LatLng(37.7749, -122.4194), // Center on a specific location
          initialZoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: _createMarkers(context),
          ),
        ],
      ),
    );
  }

  List<Marker> _createMarkers(BuildContext context) {
    // Define AQI values and their corresponding colors
    final points = [
      {'lat': 37.7749, 'lng': -122.4194, 'aqi': 30}, // Good
      {'lat': 37.7849, 'lng': -122.4294, 'aqi': 150}, // Normal
      {'lat': 37.7949, 'lng': -122.4394, 'aqi': 250}, // Poor
      {'lat': 37.8049, 'lng': -122.4494, 'aqi': 60}, // Normal
    ];

    return points.map((point) {
      final aqi = point['aqi'] as int;
      Color color;

      if (aqi < 40) {
        color = Colors.green; // Good
      } else if (aqi <= 200) {
        color = Colors.yellow; // Normal
      } else {
        color = Colors.red; // Poor
      }

      return Marker(
        point: LatLng(point['lat']!.toDouble(), point['lng']!.toDouble()),
        width: 30,
        height: 30,
        child: GestureDetector(
          onTap: () {
            // Show AQI value on tap
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('AQI Information'),
                content: Text('AQI: $aqi\nStatus: ${_getAQIStatus(aqi)}'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close'),
                  ),
                ],
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.5), // Area coloring
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  String _getAQIStatus(int aqi) {
    if (aqi < 40) {
      return 'Good';
    } else if (aqi <= 200) {
      return 'Normal';
    } else {
      return 'Poor';
    }
  }
}

void main() {
  runApp(MyApp());
}
