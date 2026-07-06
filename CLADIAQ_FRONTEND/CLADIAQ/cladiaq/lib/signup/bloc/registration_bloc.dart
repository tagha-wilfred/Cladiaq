// blocs/authentication/registration_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:cladiaq/commons/data/model/models.dart';
import 'package:cladiaq/commons/data/services/authentication_service.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthenticationService authenticationService;

  RegistrationBloc(this.authenticationService) : super(RegistrationInitial()) {
    on<RegistrationButtonPressed>((event, emit) async {
      emit(RegistrationLoading());
      try {
        final user1 = await authenticationService.register(
            event.fullName, event.email, event.password);
        print(user1);

        final CustomUser trying = CustomUser.fromJson(user1);
        print("I should be working and here is my name");
        print(trying.username);
        // await authenticationService.getToken();
        emit(RegistrationSuccess(user: user1));
      } catch (e) {
        emit(RegistrationFailure(error: e.toString()));
      }
    });
    on<GetUser>((event, emit) async {
      print("I have been called");
      emit(RegistrationLoading());
      try {
        print("I am getting User");
        final user1 = await authenticationService.getToken();
        print(user1);

        // final CustomUser trying = CustomUser.fromJson(user1);
        // print("I should be working and here is my name");
        // print(trying.username);
        // await authenticationService.getToken();
        emit(RegistrationFailure(error: "bad work"));
      } catch (e) {
        emit(RegistrationFailure(error: e.toString()));
      }
    });
  }
}
