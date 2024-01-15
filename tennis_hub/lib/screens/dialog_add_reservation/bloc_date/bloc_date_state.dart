part of 'bloc_date_bloc.dart';

class BlocDateState extends Equatable {
  const BlocDateState();

  @override
  List<Object> get props => [];
}

class BlocDateInitial extends BlocDateState {}

class DateValid extends BlocDateState {}

class DateInvalid extends BlocDateState {}
