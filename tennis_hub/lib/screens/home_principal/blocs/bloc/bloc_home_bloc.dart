import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tennis_hub/data/data_sources/implementations/db/db_impl.dart';
import 'package:tennis_hub/domain/models/reservation.dart';

part 'bloc_home_event.dart';
part 'bloc_home_state.dart';

class BlocHomeBloc extends Bloc<BlocHomeEvent, BlocHomeState> {
  DBImpl dbimpl = DBImpl();
  BlocHomeBloc() : super(BlocHomeInitial()) {
    on<LoadReservations>((event, emit) async {
      emit(BlocHomeInitial());
      List<Reservation> reservs = await dbimpl.getReservations();
      emit(ReservationsLoaded(reservs));
    });
  }
}
