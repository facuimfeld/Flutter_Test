part of 'bloc_home_bloc.dart';

class BlocHomeState extends Equatable {
  const BlocHomeState();

  @override
  List<Object> get props => [];
}

class BlocHomeInitial extends BlocHomeState {}

class ReservationsLoaded extends BlocHomeState {
  ReservationsLoaded(this.reservs);
  List<Reservation> reservs = [];

  @override
  List<Object> get props => [reservs];
}
