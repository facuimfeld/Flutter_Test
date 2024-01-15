import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_hub/domain/models/reservation.dart';
import 'package:tennis_hub/domain/models/tennis_court.dart';
import 'package:tennis_hub/screens/dialog_add_reservation/bloc_date/bloc_date_bloc.dart';
import 'package:tennis_hub/screens/dialog_add_reservation/blocs/bloc/bloc_court_bloc.dart';
import 'package:tennis_hub/screens/dialog_add_reservation/widgets/field_select_date.dart';
import 'package:tennis_hub/screens/dialog_add_reservation/widgets/field_user.dart';
import 'package:tennis_hub/screens/dialog_add_reservation/widgets/photo_url.dart';
import 'package:tennis_hub/screens/dialog_add_reservation/widgets/probability_rain.dart';
import 'package:tennis_hub/screens/home_principal/blocs/bloc/bloc_home_bloc.dart';

class DialogAddCourt extends StatefulWidget {
  @override
  State<DialogAddCourt> createState() => _DialogAddCourtState();
}

class _DialogAddCourtState extends State<DialogAddCourt> {
  int indexSelect = 0;
  DateTime time = DateTime.now();
  TextEditingController user = TextEditingController();
  DateTime? dateReservation;
  TextEditingController dateSelectedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TennisCourt courtSelected =
      TennisCourt(name: "", photoUrl: "", lights: false);
  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        dateReservation = pickedDate;
        dateSelectedController.text = dateReservation!.day.toString() +
            '\/' +
            dateReservation!.month.toString() +
            '\/' +
            dateReservation!.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<BlocCourtBloc>().add(LoadCourts());

    return AlertDialog(
      title: const Text('Nueva Reserva'),
      content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Form(
            key: _formKey,
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
                                              courtSelected = state.courts[0];
                                            });
                                            break;
                                          case 1:
                                            setState(() {
                                              indexSelect = 1;
                                              courtSelected = state.courts[1];
                                            });
                                            break;
                                          case 2:
                                            setState(() {
                                              indexSelect = 2;
                                              courtSelected = state.courts[2];
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
                                                  style: const TextStyle(
                                                      fontSize: 13.0)),
                                              subtitle: state.courts[index]
                                                          .lights ==
                                                      true
                                                  ? const Text(
                                                      'Con iluminacion',
                                                      style: TextStyle(
                                                          fontSize: 13.0))
                                                  : const Text(
                                                      'Sin iluminacion',
                                                      style: TextStyle(
                                                          fontSize: 13.0)),
                                              leading: PhotoUrl(state
                                                  .courts[index].photoUrl)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                  ],
                                );
                              }),
                          const SizedBox(height: 10.0),
                          // const Text('Fecha de Reserva',
                          //          style: TextStyle(fontSize: 13.0)),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              height: 90,
                              child: Center(
                                child: BlocBuilder<BlocDateBloc, BlocDateState>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      validator: (val) {
                                        print('state5:' + state.toString());
                                        if (state is DateValid) {
                                          return null;
                                        }
                                        return "Maximo de reservas alcanzadas";
                                      },
                                      controller: dateSelectedController,
                                      decoration: InputDecoration(
                                        icon: const Icon(Icons.calendar_today),
                                        labelText: "Seleccionar fecha",
                                        contentPadding: const EdgeInsets.only(
                                            top: 8), // Ajusta aquí
                                        suffixIcon: dateReservation == null
                                            ? const Text('')
                                            : ProbabilityRain(dateReservation!),
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        _selectDate(context);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          FieldUser(user: user),
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          )),
      actions: [
        ElevatedButton(
          onPressed: () async {
            // Validación asíncrona del BlocDateBloc
            BlocProvider.of<BlocDateBloc>(context)
                .add(ValidateDate(dateReservation!));

            // Esperar a que la validación asíncrona se complete
            await Future.delayed(Duration(
                milliseconds: 100)); // Ajusta el tiempo según sea necesario

            // Validar el formulario después de la validación asíncrona
            if (_formKey.currentState!.validate()) {
              Reservation reserv = Reservation(
                  idReservation: 0,
                  dateReservation: dateReservation!,
                  court: courtSelected,
                  user: user.text,
                  probabilityRain: 0.0);
              BlocProvider.of<BlocHomeBloc>(context)
                  .add(AddReservation(reserv));
            }
          },
          child: const Text('Agregar Reserva'),
        ),
      ],
    );
  }
}
