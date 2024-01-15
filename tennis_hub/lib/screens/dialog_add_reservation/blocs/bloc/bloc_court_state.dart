part of 'bloc_court_bloc.dart';

class BlocCourtState extends Equatable {
  const BlocCourtState();

  @override
  List<Object> get props => [];
}

class BlocCourtInitial extends BlocCourtState {}

class CourtsLoaded extends BlocCourtState {
  CourtsLoaded(this.courts);
  List<TennisCourt> courts = [];

  @override
  List<Object> get props => [courts];
}

class DatesAvailables extends BlocCourtState {
  List<DateTime> datesReserved = [];

  DatesAvailables(this.datesReserved);

  @override
  List<Object> get props => [datesReserved];
}

class ReservationSaved extends BlocCourtState {}
