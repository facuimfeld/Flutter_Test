import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tennis_hub/screens/dialog_add_reservation/widgets/probability_rain.dart';

import '../blocs/bloc/bloc_court_bloc.dart';

class FieldSelectDate extends StatefulWidget {
  final DateTime time;
  final ValueChanged<DateTime> onTimeChanged;

  const FieldSelectDate({
    Key? key,
    required this.time,
    required this.onTimeChanged,
  }) : super(key: key);

  @override
  State<FieldSelectDate> createState() => _FieldSelectDateState();
}

class _FieldSelectDateState extends State<FieldSelectDate> {
  DateTime? dateReservation;
  TextEditingController dateSelectedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<DateTime> reservedDates = [];
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
        widget.onTimeChanged(
            dateReservation!); // Llama a la función de actualización
      });

      // Forzar la validación del formulario después de cambiar la fecha
      _formKey.currentState?.validate();

      // Agrega un print para verificar si se ejecuta
      print("Formulario validado después de seleccionar la fecha");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 90,
        child: Form(
          key: _formKey,
          child: Center(
            child: TextFormField(
              validator: (val) {
                if (val!.isNotEmpty) {
                  return "Valor no vacio";
                }
              },
              controller: dateSelectedController,
              decoration: InputDecoration(
                icon: const Icon(Icons.calendar_today),
                labelText: "Seleccionar fecha",
                contentPadding: EdgeInsets.only(top: 8), // Ajusta aquí
                suffixIcon: ProbabilityRain(widget.time),
              ),
              readOnly: true,
              onTap: () async {
                _selectDate(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
