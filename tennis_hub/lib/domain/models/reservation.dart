import 'package:tennis_hub/domain/models/tennis_court.dart';

class Reservation {
  int idReservation;
  DateTime dateReservation;
  TennisCourt court;
  String user;
  double probabilityRain;

  Reservation(
      {required this.dateReservation,
      required this.court,
      required this.idReservation,
      required this.user,
      required this.probabilityRain});

  factory Reservation.fromJson(Map<String, dynamic> json) {
    print('js' + json.toString());
    TennisCourt court = TennisCourt(
        name: json["name"],
        photoUrl: json["photoUrl"],
        lights: json["lights"] == "1" ? true : false);
    return Reservation(
      idReservation: json["idReservation"],
      dateReservation: DateTime.parse(json['dateReservation']),
      court: court,
      user: json["user"],
      probabilityRain: 0.0,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'dateReservation': dateReservation,
      'user': user,
      'idCourt': null,
    };
  }
}
