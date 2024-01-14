import 'package:tennis_hub/domain/models/tennis_court.dart';

class Reservation {
  DateTime dateReservation;
  TennisCourt court;
  double probabilityRain;

  Reservation(
      {required this.dateReservation,
      required this.court,
      required this.probabilityRain});

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      dateReservation: json['dateReservation'],
      court: json['court'],
      probabilityRain: json['probabilityRain'],
    );
  }
}
