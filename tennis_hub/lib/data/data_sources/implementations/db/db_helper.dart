import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tennis_hub/data/repositories/db_repository.dart';
import 'package:tennis_hub/domain/models/reservation.dart';
import 'package:tennis_hub/domain/models/tennis_court.dart';

class DBHelper {
  static late Database datab;
  final String _nameDatabase = 'Testflutter.db';
  final String _nameTable1 = 'Court';
  final String _nameTable2 = 'Reservations';
  final int _version = 1;
  bool databaseCreated = false;

  //Insertar reservacion
  Future<bool> insertReservation(Reservation reservation) async {
    Map<String, dynamic> res = reservation.toMap();
    res["idCourt"] = await getIdCourt(reservation.court.name);
    String formattedDateString =
        DateFormat('yyyy-MM-dd').format(res["dateReservation"]);
    res["dateReservation"] = formattedDateString;
    await datab.insert(
      _nameTable2,
      res,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }

  //Inicializar base de datos
  Future<void> initDB() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _nameDatabase);

      datab = await openDatabase(path, version: _version, onCreate: _createDB);
    } catch (ex) {
      print('error init' + ex.toString());
    }
    //Si la base de datos fue recien creada se insertan canchas, caso contrario se omite la insercion
    if (databaseCreated) {
      await insertCourts();
    }
  }

  //Crear tablas en sqflite
  Future _createDB(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_nameTable1(
            idCourt INTEGER PRIMARY KEY,
            name VARCHAR(15) NOT NULL,
            photoUrl TEXT NOT NULL,
            lights CHAR(1) NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $_nameTable2(
            idReservation INTEGER PRIMARY KEY,
            user VARCHAR(50) NOT NULL,
            dateReservation TEXT NOT NULL,
            idCourt INTEGER NOT NULL,
            FOREIGN KEY(idCourt) REFERENCES Court(id)
          )
          ''');

    databaseCreated = true;
  }

  //Obtener ID de cancha por su nombre
  Future<int> getIdCourt(String nameCourt) async {
    final List<Map<String, dynamic>> maps = await datab.query(
      _nameTable1,
      columns: ['idCourt'],
      where: 'name = ?',
      whereArgs: [nameCourt],
    );

    if (maps.isNotEmpty) {
      return maps.first['idCourt'] as int;
    } else {
      return 0;
    }
  }

  //Insertar canchas a sqflite
  Future<void> insertCourts() async {
    List<TennisCourt> courts = [
      TennisCourt(
          name: 'Cancha A',
          photoUrl:
              'https://www.shutterstock.com/image-photo/tennis-court-view-artificial-turf-600nw-2291685123.jpg',
          lights: true),
      TennisCourt(
          name: 'Cancha B',
          photoUrl:
              'https://i.pinimg.com/550x/37/ba/e4/37bae49ca745e1110cb34e6e5fdd7c79.jpg',
          lights: true),
      TennisCourt(
          name: 'Cancha C',
          photoUrl:
              'https://pavipor.com/wp-content/uploads/2016/04/Pavimento_Tierra_Batida_Sintetica_5.jpg',
          lights: false),
    ];
    for (int i = 0; i <= courts.length - 1; i++) {
      await datab.insert(
        'Court',
        courts[i].toMap(),
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
    }
  }

  //Obtener reservas almacenadas
  Future<List<Map<String, dynamic>>> getReservs() async {
    List<Map<String, dynamic>> list = [];
    list = await datab.rawQuery(
        'SELECT r.idReservation,c.name, c.photoUrl, r.dateReservation,c.lights,r.user FROM Court c INNER JOIN Reservations r ON c.idCourt = r.idCourt');

    return list;
  }

  //Obtener canchas cargadas
  Future<List<Map<String, dynamic>>> getCourts() async {
    List<Map<String, dynamic>> list = [];
    list = await datab.query('Court');

    return list;
  }

  //Obtener fechas de reservaciones que hayan llegado al limite de reservas
  Future<List<String>> getDateReservations() async {
    // Realizar la consulta SQL
    List<Map<String, dynamic>> result = await datab.rawQuery('''
    SELECT dateReservation, COUNT(*) as reservationCount
    FROM $_nameTable2
    GROUP BY dateReservation
    HAVING reservationCount = 3
  ''');

    // Mapear la lista de mapas a una lista de cadenas de fechas
    List<String> dateList = result.map((map) {
      return map['dateReservation'] as String;
    }).toList();

    return dateList;
  }

  //Borramos reserva por su id
  Future<void> deleteReservation(int id) async {
    await datab
        .delete(_nameTable2, where: 'idReservation = ?', whereArgs: [id]);
  }
}
