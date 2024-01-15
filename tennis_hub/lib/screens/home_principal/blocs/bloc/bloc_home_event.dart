part of 'bloc_home_bloc.dart';

class BlocHomeEvent extends Equatable {
  const BlocHomeEvent();

  @override
  List<Object> get props => [];
}

class LoadReservations extends BlocHomeEvent {
  @override
  List<Object> get props => [];
}

class AddReservation extends BlocHomeEvent {
  Reservation reserv;

  AddReservation(this.reserv);
  @override
  List<Object> get props => [reserv];
}

class DeleteReservation extends BlocHomeEvent {
  int id;
  DeleteReservation(this.id);
  @override
  List<Object> get props => [id];
}
