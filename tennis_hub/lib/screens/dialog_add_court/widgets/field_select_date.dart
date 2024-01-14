import 'package:flutter/material.dart';

class FieldSelectDate extends StatefulWidget {
  const FieldSelectDate({Key? key}) : super(key: key);

  @override
  State<FieldSelectDate> createState() => _FieldSelectDateState();
}

class _FieldSelectDateState extends State<FieldSelectDate> {
  DateTime? dateReservation;

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
        date = dateReservation!.day.toString() +
            '\/' +
            dateReservation!.month.toString() +
            '\/' +
            dateReservation!.year.toString();
      });
    }
  }

  String date = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Container(
          child: Center(
              child: dateReservation == null
                  ? Text('Seleccionar fecha')
                  : Text(date)),
          width: 270,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(width: 1.4, color: Colors.grey),
            borderRadius: const BorderRadius.all(
              Radius.circular(7.0),
            ),
          ),
        ));
  }
}
