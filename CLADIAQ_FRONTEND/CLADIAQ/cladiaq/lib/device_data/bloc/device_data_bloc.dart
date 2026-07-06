// blocs/device_data/device_data_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:cladiaq/commons/data/model/models.dart';
import 'package:cladiaq/commons/data/services/authentication_service.dart';
import 'package:cladiaq/commons/repository/user_repository.dart';
import 'package:cladiaq/device_data/services/device_data_service.dart';
import 'device_data_event.dart';
import 'device_data_state.dart';

class DeviceDataBloc extends Bloc<DeviceDataEvent, DeviceDataState> {
  final DeviceDataService deviceDataService;

  DeviceDataBloc(this.deviceDataService) : super(DeviceDataInitial()) {
    on<FetchDeviceData>((event, emit) async {
      emit(DeviceDataLoading());
      try {
        final authService = AuthenticationService(UserRepository());
        final token = await authService.getToken();
        if (token != null) {
          final data = await deviceDataService.fetchDeviceData(token);
          final List<SensorData> sdata = SensorData.listFromJson(data);
          emit(DeviceDataLoaded(sdata));
        } else
          emit(DeviceDataError("No token to fethc"));
      } catch (e) {
        emit(DeviceDataError(e.toString()));
      }
    });
  }
}
