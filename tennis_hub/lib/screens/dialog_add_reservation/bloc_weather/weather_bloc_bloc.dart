import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tennis_hub/data/data_sources/implementations/api/weather_impl.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  Weather w = Weather();
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<CalculateProbability>((event, emit) async {
      try {
        double probability = await w.getProbabilityRain(event.time);
        emit(ProbabilityCalculated(probability));
      } catch (e) {
        print('error:' + e.toString());
      }
    });
  }
}
