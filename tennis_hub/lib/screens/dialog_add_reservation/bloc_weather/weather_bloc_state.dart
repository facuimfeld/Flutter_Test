part of 'weather_bloc_bloc.dart';

class WeatherBlocState extends Equatable {
  const WeatherBlocState();

  @override
  List<Object> get props => [];
}

class WeatherBlocInitial extends WeatherBlocState {}

class ProbabilityCalculated extends WeatherBlocState {
  double probability;
  ProbabilityCalculated(this.probability);

  @override
  List<Object> get props => [probability];
}
