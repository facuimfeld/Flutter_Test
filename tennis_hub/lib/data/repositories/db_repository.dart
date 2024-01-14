import 'package:tennis_hub/domain/models/reservation.dart';
import 'package:tennis_hub/domain/models/tennis_court.dart';

abstract class DBRepository {
  Future<List<Reservation>> getReservations();

  Future<bool> addReservation(Reservation reservation);

  Future<List<TennisCourt>> getCourts();
}
