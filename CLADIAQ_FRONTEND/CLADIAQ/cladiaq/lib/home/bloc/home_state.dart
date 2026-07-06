part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}

// Abstract state that includes the loaded sensor data
abstract class HomeLoadedState extends HomeState {
  final List<SensorData> sensorDataList;
  final AQIsum aqiSum;

  HomeLoadedState({required this.sensorDataList, required this.aqiSum});

  // Method to allow copying the state while retaining the loaded data
  HomeLoadedState copyWith({
    List<SensorData>? sensorDataList,
    AQIsum? aqi,
  });
}

final class HomeHomeState extends HomeLoadedState {
  HomeHomeState({required List<SensorData> sensorDataList, required AQIsum aqi})
      : super(sensorDataList: sensorDataList, aqiSum: aqi);

  @override
  HomeHomeState copyWith({
    List<SensorData>? sensorDataList,
    AQIsum? aqi,
  }) {
    return HomeHomeState(
        sensorDataList: sensorDataList ?? this.sensorDataList,
        aqi: aqi ?? this.aqiSum);
  }
}

final class HomeGasState extends HomeLoadedState {
  HomeGasState({required List<SensorData> sensorDataList, required AQIsum aqi})
      : super(sensorDataList: sensorDataList, aqiSum: aqi);
  @override
  HomeGasState copyWith({
    List<SensorData>? sensorDataList,
    AQIsum? aqi,
  }) {
    return HomeGasState(
        sensorDataList: sensorDataList ?? this.sensorDataList,
        aqi: aqi ?? this.aqiSum);
  }
}

final class HomeAtmState extends HomeLoadedState {
  HomeAtmState({required List<SensorData> sensorDataList, required AQIsum aqi})
      : super(sensorDataList: sensorDataList, aqiSum: aqi);
  @override
  HomeAtmState copyWith({
    List<SensorData>? sensorDataList,
    AQIsum? aqi,
  }) {
    return HomeAtmState(
        sensorDataList: sensorDataList ?? this.sensorDataList,
        aqi: aqi ?? this.aqiSum);
  }
}

final class HomeLiveState extends HomeLoadedState {
  HomeLiveState({required List<SensorData> sensorDataList, required AQIsum aqi})
      : super(sensorDataList: sensorDataList, aqiSum: aqi);

  @override
  HomeLiveState copyWith({
    List<SensorData>? sensorDataList,
    AQIsum? aqi,
  }) {
    return HomeLiveState(
        sensorDataList: sensorDataList ?? this.sensorDataList,
        aqi: aqi ?? this.aqiSum);
  }
}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
