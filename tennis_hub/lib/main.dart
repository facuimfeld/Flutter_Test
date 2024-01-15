import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_hub/data/data_sources/implementations/api/weather_impl.dart';
import 'package:tennis_hub/data/data_sources/implementations/db/db_helper.dart';
import 'package:tennis_hub/screens/dialog_add_reservation/bloc_date/bloc_date_bloc.dart';

import 'package:tennis_hub/screens/dialog_add_reservation/bloc_weather/weather_bloc_bloc.dart';
import 'package:tennis_hub/screens/dialog_add_reservation/blocs/bloc/bloc_court_bloc.dart';

import 'package:tennis_hub/screens/home_principal/blocs/bloc/bloc_home_bloc.dart';
import 'package:tennis_hub/screens/home_principal/home_principal.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper db = DBHelper();
  try {
    await db.initDB();
    print('Database initialized successfully.');
  } catch (e) {
    print('error:' + e.toString());
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BlocHomeBloc>(create: (context) => BlocHomeBloc()),
          BlocProvider<BlocCourtBloc>(create: (context) => BlocCourtBloc()),
          BlocProvider<WeatherBlocBloc>(create: (context) => WeatherBlocBloc()),
          BlocProvider<BlocDateBloc>(create: (context) => BlocDateBloc()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TennisHub',
            home: HomePrincipal()));
  }
}
