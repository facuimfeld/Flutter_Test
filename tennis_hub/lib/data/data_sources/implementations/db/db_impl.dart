import 'package:tennis_hub/data/data_sources/implementations/db/db_helper.dart';
import 'package:tennis_hub/data/data_sources/interfaces/reservations.dart';
import 'package:tennis_hub/data/repositories/db_repository.dart';
import 'package:tennis_hub/domain/models/reservation.dart';
import 'package:tennis_hub/domain/models/tennis_court.dart';

class DBImpl implements DBRepository {
  DBHelper database = DBHelper();
  @override
  Future<bool> addReservation(Reservation reservation) async {
    await database.insertReservation(reservation);
    return true;
  }

  @override
  Future<bool> deleteReservation(int id) async {
    await database.deleteReservation(id);
    return true;
  }

  @override
  Future<List<Reservation>> getReservations() async {
    List<Reservation> list = [];
    List<Map<String, dynamic>> reservations = await database.getReservs();
    reservations.forEach((itemMap) {
      list.add(Reservation.fromJson(itemMap));
    });
    return list;
  }

  @override
  Future<List<TennisCourt>> getCourts() async {
    List<Map<String, dynamic>> rows = await database.getCourts();
    List<TennisCourt> courts = rows.map((e) => TennisCourt.fromMap(e)).toList();
    return courts;
  }

  @override
  Future<List<String>> getDateReservations() async {
    List<String> result = await database.getDateReservations();

    return result;
  }
}
