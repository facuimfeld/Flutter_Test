import 'package:tennis_hub/domain/models/reservation.dart';
import 'package:tennis_hub/domain/models/tennis_court.dart';

abstract class DBRepository {
  Future<List<Reservation>> getReservations();

  Future<bool> addReservation(Reservation reservation);

  Future<List<TennisCourt>> getCourts();

  Future<bool> validateDateReservation(DateTime reservation);

  Future<List<String>> getDateReservations();

  Future<void> deleteReservation(int id);
}
