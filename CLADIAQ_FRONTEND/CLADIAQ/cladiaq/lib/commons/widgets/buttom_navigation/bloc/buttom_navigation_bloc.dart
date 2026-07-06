import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'buttom_navigation_event.dart';
part 'buttom_navigation_state.dart';

class ButtomNavigationBloc
    extends Bloc<ButtomNavigationEvent, ButtomNavigationState> {
  ButtomNavigationBloc() : super(ButtomNavigationHome()) {
    on<ButtomNavigationEvent>((event, emit) {});

    on<HomeButtonClicked>((event, emit) {
      print("home");
      emit(ButtomNavigationHome());
    });

    on<NewsButtonClicked>((event, emit) {
      print("News");
      emit(ButtomNavigationNews());
    });

    on<SettingsButtonClicked>((event, emit) {
      print("Settings");
      emit(ButtomNavigationSetting());
    });

    on<ChatBotButtonClicked>((event, emit) {
      print("Chatbot");
      emit(ButtomNavigationChatBot());
    });
  }
}
