import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tennis_hub/data/data_sources/implementations/api/weather_impl.dart';
import 'package:tennis_hub/data/data_sources/implementations/db/db_impl.dart';
import 'package:tennis_hub/domain/models/reservation.dart';
import 'package:tennis_hub/domain/models/tennis_court.dart';

part 'bloc_home_event.dart';
part 'bloc_home_state.dart';

class BlocHomeBloc extends Bloc<BlocHomeEvent, BlocHomeState> {
  DBImpl dbimpl = DBImpl();
  Weather w = Weather();
  BlocHomeBloc() : super(BlocHomeInitial()) {
    on<LoadReservations>((event, emit) async {
      List<Reservation> reservations = await dbimpl
          .getReservations(); // Implementa la lógica para obtener las reservas
      for (var reservation in reservations) {
        try {
          double probability =
              await w.getProbabilityRain(reservation.dateReservation);
          reservation.probabilityRain = probability;
        } catch (e) {
          print('error:' + e.toString());
        }
      }
      emit(ReservationsLoaded(reservations));
    });
    on<AddReservation>((event, emit) async {
      emit(BlocHomeInitial());
      try {
        await dbimpl.addReservation(event.reserv);
      } catch (e) {
        print('error:' + e.toString());
      }

      emit(ReservationSaved());
    });
    on<DeleteReservation>((event, emit) async {
      emit(BlocHomeInitial());
      try {
        await dbimpl.deleteReservation(event.id);
      } catch (e) {
        print('error:' + e.toString());
      }

      emit(ReservationDeleted());
    });
  }
}
