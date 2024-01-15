part of 'bloc_date_bloc.dart';

class BlocDateEvent extends Equatable {
  const BlocDateEvent();

  @override
  List<Object> get props => [];
}

class ValidateDate extends BlocDateEvent {
  DateTime date;
  ValidateDate(this.date);

  @override
  List<Object> get props => [date];
}
