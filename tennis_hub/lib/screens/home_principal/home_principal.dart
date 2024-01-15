import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_hub/data/data_sources/implementations/api/weather_impl.dart';
import 'package:tennis_hub/screens/dialog_add_reservation/bloc_weather/weather_bloc_bloc.dart';
import 'package:tennis_hub/screens/home_principal/blocs/bloc/bloc_home_bloc.dart';
import 'package:tennis_hub/screens/home_principal/widgets/button_add_reservation.dart';

class HomePrincipal extends StatefulWidget {
  @override
  State<HomePrincipal> createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocHomeBloc>(context).add(LoadReservations());
  }

  @override
  Widget build(BuildContext context) {
    context.read<BlocHomeBloc>().add(LoadReservations());
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('TennisHub')),
      body: BlocListener<BlocHomeBloc, BlocHomeState>(
        listener: (context, state) {
          if (state is ReservationSaved || state is ReservationDeleted) {
            BlocProvider.of<BlocHomeBloc>(context).add(LoadReservations());
          }
        },
        child: BlocBuilder<BlocHomeBloc, BlocHomeState>(
            builder: ((context, state) {
          print('state1:' + state.toString());
          if (state is ReservationsLoaded) {
            if (state.reservs.isEmpty) {
              return const Center(
                child: Text('Sin reservas agendadas'),
              );
            }
            state.reservs.sort(
              (a, b) {
                DateTime fechaA = a.dateReservation;
                DateTime fechaB = b.dateReservation;
                return fechaA.compareTo(fechaB);
              },
            );
            return DataTable(
              sortColumnIndex: 0, // Índice de la columna por la que se ordena
              sortAscending: true, // Orden ascendente por defecto
              columnSpacing: 10,
              columns: const [
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Usuario')),
                DataColumn(label: Text('Cancha')),
                DataColumn(label: Text('Prob Lluvia')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: state.reservs.map((data) {
                return DataRow(
                  cells: [
                    DataCell(Text(
                        '${data.dateReservation.day}\/${data.dateReservation.month}\/${data.dateReservation.year}')),
                    DataCell(Text(data.user.toString())),
                    DataCell(Text(data.court.name)),
                    DataCell(
                        Text(data.probabilityRain.toStringAsFixed(2) + '%')),
                    DataCell(IconButton(
                        onPressed: () {
                          BlocProvider.of<BlocHomeBloc>(context)
                              .add(DeleteReservation(data.idReservation));
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))),
                  ],
                );
              }).toList(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        })),
      ),
      floatingActionButton: const ButtonAddReservation(),
    );
  }
}
