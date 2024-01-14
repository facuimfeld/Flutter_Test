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
