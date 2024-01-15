import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tennis_hub/data/data_sources/implementations/api/weather_impl.dart';
import 'package:tennis_hub/data/data_sources/implementations/db/db_impl.dart';
import 'package:tennis_hub/domain/models/tennis_court.dart';

part 'bloc_court_event.dart';
part 'bloc_court_state.dart';

class BlocCourtBloc extends Bloc<BlocCourtEvent, BlocCourtState> {
  DBImpl dbimpl = DBImpl();
  final TextEditingController user = TextEditingController();
  DateTime? timeReservation;
  Weather weath = Weather();
  BlocCourtBloc() : super(BlocCourtInitial()) {
    on<LoadCourts>((event, emit) async {
      emit(BlocCourtInitial());
      List<TennisCourt> courts = await dbimpl.getCourts();
      emit(CourtsLoaded(courts));
    });
  }
}
