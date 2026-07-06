// blocs/authentication/login_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:cladiaq/commons/data/services/authentication_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService authenticationService;

  LoginBloc(this.authenticationService) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final user1 =
            await authenticationService.login(event.email, event.password);
        print(user1.toString());
        emit(LoginSuccess(user: user1));
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
