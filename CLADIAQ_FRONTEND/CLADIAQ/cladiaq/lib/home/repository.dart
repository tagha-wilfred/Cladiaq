import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cladiaq/commons/data/model/models.dart';

class SensorDataRepository {
  // final String _baseUrl = 'http://13.61.33.10:8000/api/sensor-data';
  final String _baseUrl = 'http://13.60.4.19:8000/apid/sensor-data';
  // final String _baseUrl = 'http://10.0.2.2:8000/apid/sensor-data';

  final String _cacheKey = 'cached_sensor_data';
  final String _cacheTimeKey = 'cache_time_key';
  final Duration _cacheExpiryDuration =
      Duration(hours: 12); // Set cache expiry duration

  // Fetch data from API
  Future<List<SensorData>> fetchSensorData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        print("I have succeeded to get the data");
        // Parse the JSON
        final List<dynamic> jsonData = jsonDecode(response.body);
        // Convert to list of SensorData objects
        List<SensorData> sensorDataList = SensorData.listFromJson(jsonData);
        print(sensorDataList.toString());

        // Cache the data locally
        await cacheSensorData(sensorDataList);

        return sensorDataList;
      } else {
        throw Exception('Failed to load sensor data: ${response.statusCode}');
      }
    } catch (e) {
      // Log error and return an empty list
      print('Error fetching sensor data: $e');
      return [];
    }
  }

  // Cache the fetched sensor data for offline use
  Future<void> cacheSensorData(List<SensorData> sensorDataList) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the data to JSON before saving
    List<String> jsonStringList =
        sensorDataList.map((data) => jsonEncode(data.toJson())).toList();
    await prefs.setStringList(_cacheKey, jsonStringList);

    // Store the current timestamp for cache expiry
    await prefs.setInt(_cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  // Retrieve cached sensor data if there's no internet
  Future<List<SensorData>> getCachedSensorData() async {
    print("I am about to be gotten");
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cachedData = prefs.getStringList(_cacheKey);
    final int? cacheTime = prefs.getInt(_cacheTimeKey);
    print(cachedData!.length);

    // Check if the cache has expired
    if (cachedData != null && cacheTime != null) {
      final cacheExpiryTime = DateTime.fromMillisecondsSinceEpoch(cacheTime);
      if (DateTime.now().isBefore(cacheExpiryTime.add(_cacheExpiryDuration))) {
        // Convert cached JSON strings back to SensorData objects
        List<SensorData> sensorDataList = cachedData
            .map((data) => SensorData.fromJson(jsonDecode(data)))
            .toList();
        print(sensorDataList.length);
        print("done");
        return sensorDataList;
      } else {
        print("expired Cache");
        // Clear expired cache
        await prefs.remove(_cacheKey);
        await prefs.remove(_cacheTimeKey);
      }
    }

    return []; // Return empty list if no cached data is found or if cache has expired
  }
}
