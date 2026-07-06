// screens/home/home_view.dart
import 'package:cladiaq/commons/data/model/models.dart';
import 'package:cladiaq/commons/data/services/authentication_service.dart';
import 'package:cladiaq/commons/repository/user_repository.dart';
import 'package:cladiaq/commons/widgets/buttom_navigation/cq_buttomn_nav_bar.dart';
import 'package:cladiaq/device_data/bloc/device_data_bloc.dart';
import 'package:cladiaq/device_data/bloc/device_data_event.dart';
import 'package:cladiaq/device_data/bloc/device_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the AuthenticationService to get the token
    // Ensure this method returns the current token

    // Dispatch the event to fetch device data
    context.read<DeviceDataBloc>().add(FetchDeviceData());

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<DeviceDataBloc, DeviceDataState>(
        builder: (context, state) {
          if (state is DeviceDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DeviceDataLoaded) {
            return ListView.builder(
              itemCount: state.deviceData.length,
              itemBuilder: (context, index) {
                final SensorData device = state
                    .deviceData[index]; // Adjust based on your data structure
                return ListTile(
                  title: Text(
                      'Device: ${device.temperature}'), // Adjust based on your data structure
                  subtitle: Text(
                      'Status: ${device.time}'), // Adjust based on your data structure
                );
              },
            );
          } else if (state is DeviceDataError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No data available'));
        },
      ),
      // bottomNavigationBar: CqButtomnNavBar(),
    );
  }
}
