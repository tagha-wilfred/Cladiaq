// blocs/authentication/registration_event.dart
abstract class RegistrationEvent {}

class RegistrationButtonPressed extends RegistrationEvent {
  final String fullName;
  final String email;
  final String mobile;
  final String password;

  RegistrationButtonPressed({
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.password,
  });
}

class GetUser extends RegistrationEvent {}
