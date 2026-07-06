part of 'home_bloc.dart';

@immutable
class HomeEvent {}

class HomeStartEvent extends HomeEvent {}

class HomeButtonClickedEvent extends HomeEvent {}

class GasButtonClickedEvent extends HomeEvent {}

class AtmButtonClickedEvent extends HomeEvent {}

class LiveButtonClickedEvent extends HomeEvent {}
