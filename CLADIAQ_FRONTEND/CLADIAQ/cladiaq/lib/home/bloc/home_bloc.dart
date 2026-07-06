import 'package:bloc/bloc.dart';
import 'package:cladiaq/commons/data/model/models.dart';
import 'package:cladiaq/home/aqui_calculate.dart';
import 'package:cladiaq/home/repository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SensorDataRepository sensorDataRepository;

  HomeBloc({required this.sensorDataRepository}) : super(HomeInitial()) {
    // Event handling for loading data
    on<HomeStartEvent>((event, emit) async {
      emit(HomeLoadingState()); // Emit loading state

      try {
        final sensorDataList = await sensorDataRepository.fetchSensorData();
        final b = sensorDataList.last;
        print(b.c5h5);
        final aqi = calculateAQI(
            temperature: b.temperature ?? 0,
            pressure: b.atmPressure ?? 0,
            sound: b.inflamables ?? 0,
            humidity: b.humidity ?? 0,
            co2: b.co2 ?? 0,
            nh3: b.nh3 ?? 0,
            co: b.co ?? 0,
            cov: b.cov ?? 0,
            o3: b.o3 ?? 0,
            c5h5: b.c5h5 ?? 0);
        final aqisum = AQIsum(
            aqi,
            b.temperature ?? 0,
            (b.inflamables ?? 0).round(),
            (b.humidity ?? 0).round(),
            (b.atmPressure ?? 0).round());

        await sensorDataRepository.cacheSensorData(sensorDataList);

        emit(HomeHomeState(
            sensorDataList: sensorDataList, aqi: aqisum)); // Emit loaded state
      } catch (error) {
        print("error occured");
        final cachedData = await sensorDataRepository.getCachedSensorData();

        if (cachedData.isNotEmpty) {
          emit(HomeHomeState(
              sensorDataList: cachedData,
              aqi: AQIsum(0, 0, 0, 0, 0))); // Load from cache if API fails
        } else {
          emit(HomeErrorState('Failed to load data and no cached data found'));
        }
      }
    });

    on<HomeButtonClickedEvent>((event, emit) {
      // Transition to ATM state from any current state
      emit(HomeHomeState(
          sensorDataList: (state as dynamic).sensorDataList,
          aqi: (state as dynamic).aqiSum));
    });

    // Handle button clicks, transitioning between states
    on<AtmButtonClickedEvent>((event, emit) {
      // Transition to ATM state from any current state
      emit(HomeAtmState(
          sensorDataList: (state as dynamic).sensorDataList,
          aqi: (state as dynamic).aqiSum));
    });

    on<GasButtonClickedEvent>((event, emit) {
      // Transition to Gas state from any current state
      emit(HomeGasState(
          sensorDataList: (state as dynamic).sensorDataList,
          aqi: (state as dynamic).aqiSum));
    });

    on<LiveButtonClickedEvent>((event, emit) {
      // Transition to Live state from any current state
      emit(HomeLiveState(
          sensorDataList: (state as dynamic).sensorDataList,
          aqi: (state as dynamic).aqiSum));
    });
  }
}
