// services/device_data_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class DeviceDataService {
  Future<List<dynamic>> fetchDeviceData(String token) async {
    final response = await http.get(
      // Uri.parse('http://13.61.33.10:8000/api/sensor-data'),
      Uri.parse('http://13.60.4.19:8000/apid/sensor-data'),
      // Uri.parse('http://10.0.2.2:8000/apid/sensor-data'),

      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json', // Adjust if required
      },
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body); // Adjust based on your API response
    } else {
      throw Exception('Failed to load device data');
    }
  }
}
