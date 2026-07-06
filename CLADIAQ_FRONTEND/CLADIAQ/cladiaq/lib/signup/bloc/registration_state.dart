// blocs/authentication/registration_state.dart

import 'package:cladiaq/commons/data/model/models.dart';

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final user;
  RegistrationSuccess({required this.user});
}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure({required this.error});
}
