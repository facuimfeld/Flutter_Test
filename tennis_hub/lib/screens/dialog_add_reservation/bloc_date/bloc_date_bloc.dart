import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tennis_hub/data/data_sources/implementations/db/db_helper.dart';
import 'package:tennis_hub/data/data_sources/implementations/db/db_impl.dart';

part 'bloc_date_event.dart';
part 'bloc_date_state.dart';

class BlocDateBloc extends Bloc<BlocDateEvent, BlocDateState> {
  DBHelper datab = DBHelper();
  BlocDateBloc() : super(BlocDateInitial()) {
    on<ValidateDate>((event, emit) async {
      List<String> datesReservedLimit = await datab.getDateReservations();
      print('dates reserv' + datesReservedLimit.toString());
      String year = event.date.year.toString();
      String month = event.date.month.toString();
      String day = event.date.day.toString();
      print('eventmon' + event.date.month.toString());
      if (event.date.month < 10) {
        month = '0' + month;
      }
      if (event.date.day < 10) {
        day = '0' + day;
      }
      String dateSelected = year + '-' + month + '-' + day;
      print('dateselected' + dateSelected);
      if (datesReservedLimit.contains(dateSelected)) {
        emit(DateInvalid());
      } else {
        emit(DateValid());
      }
    });
  }
}
