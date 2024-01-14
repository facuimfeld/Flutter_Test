import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tennis_hub/screens/dialog_add_court/dialog_add_court.dart';

class ButtonAddReservation extends StatelessWidget {
  const ButtonAddReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return DialogAddCourt();
            });
      },
      child: const Center(child: Icon(Icons.add)),
    );
  }
}
