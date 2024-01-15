part of 'weather_bloc_bloc.dart';

class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class CalculateProbability extends WeatherBlocEvent {
  DateTime time;
  CalculateProbability(this.time);

  @override
  List<Object> get props => [];
}
