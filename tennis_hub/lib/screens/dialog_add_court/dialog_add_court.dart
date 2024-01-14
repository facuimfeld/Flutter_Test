import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_hub/screens/dialog_add_court/blocs/bloc/bloc_court_bloc.dart';
import 'package:tennis_hub/screens/dialog_add_court/widgets/field_select_date.dart';
import 'package:tennis_hub/screens/dialog_add_court/widgets/photo_url.dart';

class DialogAddCourt extends StatefulWidget {
  @override
  State<DialogAddCourt> createState() => _DialogAddCourtState();
}

class _DialogAddCourtState extends State<DialogAddCourt> {
  int indexSelect = 0;

  @override
  Widget build(BuildContext context) {
    context.read<BlocCourtBloc>().add(LoadCourts());
    return AlertDialog(
      title: const Text('Nueva Reserva'),
      content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Seleccione una cancha',
                  style: TextStyle(fontSize: 13.0)),
              const SizedBox(height: 10.0),
              BlocBuilder<BlocCourtBloc, BlocCourtState>(
                builder: (context, state) {
                  if (state is CourtsLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.courts.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          setState(() {
                                            indexSelect = 0;
                                          });
                                          break;
                                        case 1:
                                          setState(() {
                                            indexSelect = 1;
                                          });
                                          break;
                                        case 2:
                                          setState(() {
                                            indexSelect = 2;
                                          });
                                          break;
                                      }
                                    },
                                    child: Container(
                                      width: 270,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: indexSelect == index
                                              ? Colors.blue
                                              : Colors.grey,
                                          width: 1.4,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: ListTile(
                                            title: Text(
                                                state.courts[index].name,
                                                style:
                                                    TextStyle(fontSize: 13.0)),
                                            subtitle: state
                                                        .courts[index].lights ==
                                                    true
                                                ? const Text('Con iluminacion',
                                                    style: TextStyle(
                                                        fontSize: 13.0))
                                                : const Text('Sin iluminacion',
                                                    style: TextStyle(
                                                        fontSize: 13.0)),
                                            leading: PhotoUrl(
                                                state.courts[index].photoUrl)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                ],
                              );
                            }),
                        const SizedBox(height: 10.0),
                        const Text('Fecha de Reserva',
                            style: TextStyle(fontSize: 13.0)),
                        FieldSelectDate(),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          )),
    );
  }
}
