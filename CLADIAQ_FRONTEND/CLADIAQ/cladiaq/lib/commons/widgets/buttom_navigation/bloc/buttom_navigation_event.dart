part of 'buttom_navigation_bloc.dart';

@immutable
class ButtomNavigationEvent {}

final class HomeButtonClicked extends ButtomNavigationEvent {}

final class NewsButtonClicked extends ButtomNavigationEvent {}

final class SettingsButtonClicked extends ButtomNavigationEvent {}

final class ChatBotButtonClicked extends ButtomNavigationEvent {}
