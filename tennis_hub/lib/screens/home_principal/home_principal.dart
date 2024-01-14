import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_hub/screens/home_principal/blocs/bloc/bloc_home_bloc.dart';
import 'package:tennis_hub/screens/home_principal/widgets/button_add_reservation.dart';

class HomePrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<BlocHomeBloc>().add(LoadReservations());
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('TennisHub')),
      body:
          BlocBuilder<BlocHomeBloc, BlocHomeState>(builder: ((context, state) {
        if (state is ReservationsLoaded) {
          if (state.reservs.isEmpty) {
            return const Center(
              child: Text('Sin reservas agendadas'),
            );
          }
          return ListView.builder(
              itemCount: state.reservs.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text(state.reservs[index].court.name),
                );
              }));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      })),
      floatingActionButton: ButtonAddReservation(),
    );
  }
}
